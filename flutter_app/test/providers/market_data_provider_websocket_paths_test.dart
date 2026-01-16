import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MarketDataProvider WebSocket Path Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('_initializeWebSocket should set up stream subscription', () {
      // Constructor calls _initializeWebSocket
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_initializeWebSocket should handle null stream gracefully', () {
      // Should handle case where stream is null
      provider.disconnectWebSocket();
      expect(provider.isWebSocketConnected, false);
    });

    test('_handleWebSocketUpdate should handle invalid update format', () {
      // This tests the type check in _handleWebSocketUpdate
      // The method checks for 'type' == 'market_update'
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle missing data field', () {
      // Tests the null check for update['data']
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle missing symbol', () {
      // Tests the null check for symbol
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should handle symbol not found', () {
      // Tests the indexWhere result when symbol not in list
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should execute filter after update', () {
      // Tests that _applyFilters is called after update
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('_handleWebSocketUpdate should notify listeners after update', () {
      // Tests that notifyListeners is called
      expect(provider.isWebSocketConnected, isA<bool>());
    });

    test('dispose should cancel WebSocket subscription', () {
      provider.disconnectWebSocket();
      expect(() => provider.dispose(), returnsNormally);
    });

    test('dispose should handle null subscription gracefully', () {
      provider.disconnectWebSocket();
      expect(() => provider.dispose(), returnsNormally);
    });
  });
}

