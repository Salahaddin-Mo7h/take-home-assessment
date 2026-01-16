import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';

void main() {
  group('MarketDataProvider WebSocket Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('should initialize WebSocket on creation', () {
      // WebSocket is initialized in constructor
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('should handle WebSocket disconnection', () {
      expect(() => provider.disconnectWebSocket(), returnsNormally);
      expect(provider.isWebSocketConnected, false);
    });

    test('should allow multiple disconnect calls', () {
      provider.disconnectWebSocket();
      expect(() => provider.disconnectWebSocket(), returnsNormally);
    });

    test('should have WebSocket connection status getter', () {
      final status = provider.isWebSocketConnected;
      expect(status, isA<bool>());
    });
  });
}

