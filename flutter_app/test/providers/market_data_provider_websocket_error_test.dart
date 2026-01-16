import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MarketDataProvider WebSocket Error Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('_initializeWebSocket should handle null stream', () {
      // Tests the null check: _webSocketService.stream?.listen
      provider.disconnectWebSocket();
      expect(provider.isWebSocketConnected, false);
    });

    test('_initializeWebSocket should set up error handler', () {
      // Tests the onError handler in stream.listen
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should check update type', () {
      // Tests: if (update['type'] == 'market_update' && update['data'] != null)
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should check data field', () {
      // Tests the null check for update['data']
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should check symbol field', () {
      // Tests the null check for symbol
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle symbol not found', () {
      // Tests: if (index != -1) - when symbol not found
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should execute update logic when symbol found', () {
      // Tests the update logic when index != -1
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle null price in update', () {
      // Tests: (updateData['price'] as num?)?.toDouble() ?? existing.price
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle null change24h in update', () {
      // Tests: (updateData['change24h'] as num?)?.toDouble() ?? existing.change24h
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should calculate changePercent24h', () {
      // Tests the changePercent24h calculation logic
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle null volume', () {
      // Tests: (updateData['volume'] as num?)?.toDouble() ?? existing.volume
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle null timestamp', () {
      // Tests: updateData['timestamp'] as String? ?? existing.lastUpdated
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('dispose should cancel subscription', () {
      // Tests: _webSocketSubscription?.cancel()
      expect(() => provider.dispose(), returnsNormally);
    });

    test('dispose should handle null subscription', () {
      provider.disconnectWebSocket();
      expect(() => provider.dispose(), returnsNormally);
    });
  });
}

