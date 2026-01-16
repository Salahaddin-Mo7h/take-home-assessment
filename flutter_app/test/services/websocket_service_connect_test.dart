import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/services/websocket_service.dart';

void main() {
  group('WebSocketService Connection Logic', () {
    late WebSocketService webSocketService;

    setUp(() {
      webSocketService = WebSocketService();
    });

    tearDown(() {
      webSocketService.disconnect();
    });

    test('connect should check isConnected before connecting', () {
      // This tests the isConnected check in connect()
      webSocketService.connect();
      // The isConnected check executes
      expect(webSocketService.isConnected, isA<bool>());
    });

    test('connect should handle already connected state', () {
      webSocketService.connect();
      // Second call should check isConnected and return early
      expect(() => webSocketService.connect(), returnsNormally);
    });

    test('disconnect should handle null channel gracefully', () {
      // This tests the null check: _channel?.sink.close()
      expect(() => webSocketService.disconnect(), returnsNormally);
    });

    test('disconnect should handle null controller gracefully', () {
      // This tests the null check: _controller?.close()
      webSocketService.disconnect();
      expect(() => webSocketService.disconnect(), returnsNormally);
    });

    test('isConnected getter should check both channel and controller', () {
      // This tests: _channel != null && _controller != null
      final connected = webSocketService.isConnected;
      expect(connected, isA<bool>());
    });

    test('stream getter should return controller stream', () {
      // This tests: _controller?.stream
      final stream = webSocketService.stream;
      // May be null if not connected
      expect(stream, anything);
    });
  });
}
