import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/services/websocket_service.dart';

void main() {
  group('WebSocketService', () {
    late WebSocketService webSocketService;

    setUp(() {
      webSocketService = WebSocketService();
    });

    tearDown(() {
      webSocketService.disconnect();
    });

    test('should initialize with disconnected state', () {
      // Assert
      expect(webSocketService.isConnected, false);
      expect(webSocketService.stream, isNull);
    });

    test('should have connect method', () {
      // Assert
      expect(webSocketService.connect, isA<Function>());
    });

    test('should have disconnect method', () {
      // Assert
      expect(webSocketService.disconnect, isA<Function>());
    });

    test('should have stream getter', () {
      // Assert
      expect(webSocketService.stream, isNull);
    });

    test('should have isConnected getter', () {
      // Assert
      expect(webSocketService.isConnected, isA<bool>());
    });

    test('should allow multiple disconnect calls', () {
      // Act & Assert - should not throw
      expect(() => webSocketService.disconnect(), returnsNormally);
      expect(() => webSocketService.disconnect(), returnsNormally);
    });
  });
}

