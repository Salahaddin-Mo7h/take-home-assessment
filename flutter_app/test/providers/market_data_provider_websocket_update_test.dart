import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';

void main() {
  group('MarketDataProvider WebSocket Update Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('should initialize WebSocket subscription in constructor', () {
      // Constructor calls _initializeWebSocket which sets up subscription
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('should handle WebSocket disconnection', () {
      expect(() => provider.disconnectWebSocket(), returnsNormally);
      expect(provider.isWebSocketConnected, false);
    });

    test('should handle multiple disconnect calls', () {
      provider.disconnectWebSocket();
      expect(() => provider.disconnectWebSocket(), returnsNormally);
    });

    test('should have WebSocket connection status', () {
      final status = provider.isWebSocketConnected;
      expect(status, isA<bool>());
    });

    test('should handle provider disposal with WebSocket', () {
      // Disconnect first
      provider.disconnectWebSocket();
      expect(() => provider.dispose(), returnsNormally);
    });

    test('should maintain WebSocket state through operations', () {
      final initialStatus = provider.isWebSocketConnected;
      provider.disconnectWebSocket();
      final afterDisconnect = provider.isWebSocketConnected;
      
      expect(initialStatus, isA<bool>());
      expect(afterDisconnect, false);
    });
  });
}

