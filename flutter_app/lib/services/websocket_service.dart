import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _controller;
  
  Stream<Map<String, dynamic>>? get stream => _controller?.stream;
  
  bool get isConnected => _channel != null && _controller != null;
  
  void connect() {
    if (isConnected) {
      return;
    }
    
    try {
      _controller = StreamController<Map<String, dynamic>>.broadcast();
      _channel = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));
      
      _channel!.stream.listen(
        (message) {
          try {
            final data = json.decode(message) as Map<String, dynamic>;
            _controller?.add(data);
          } catch (e) {
            _controller?.addError('Failed to parse message: $e');
          }
        },
        onError: (error) {
          _controller?.addError('WebSocket error: $error');
        },
        onDone: () {
          _controller?.close();
          _channel = null;
          _controller = null;
        },
      );
    } catch (e) {
      _controller?.addError('Failed to connect: $e');
    }
  }
  
  void disconnect() {
    _channel?.sink.close();
    _controller?.close();
    _channel = null;
    _controller = null;
  }
}
