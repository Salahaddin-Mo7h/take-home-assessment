import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';

void main() {
  group('MarketData', () {
    test('should create MarketData from valid JSON', () {
      final json = {
        'symbol': 'BTC/USD',
        'price': 43250.50,
        'change24h': 2.5,
        'changePercent24h': 2.5,
        'volume': 1250000000,
        'high24h': 44500.00,
        'low24h': 42000.00,
        'marketCap': 850000000000,
        'lastUpdated': '2024-01-01T00:00:00Z',
      };

      final marketData = MarketData.fromJson(json);

      expect(marketData.symbol, 'BTC/USD');
      expect(marketData.price, 43250.50);
      expect(marketData.change24h, 2.5);
      expect(marketData.changePercent24h, 2.5);
      expect(marketData.volume, 1250000000);
      expect(marketData.high24h, 44500.00);
      expect(marketData.low24h, 42000.00);
      expect(marketData.marketCap, 850000000000);
      expect(marketData.lastUpdated, '2024-01-01T00:00:00Z');
    });

    test('should handle null optional fields', () {
      final json = {
        'symbol': 'BTC/USD',
        'price': 43250.50,
        'change24h': 2.5,
        'changePercent24h': 2.5,
        'volume': 1250000000,
      };

      final marketData = MarketData.fromJson(json);

      expect(marketData.symbol, 'BTC/USD');
      expect(marketData.price, 43250.50);
      expect(marketData.high24h, isNull);
      expect(marketData.low24h, isNull);
      expect(marketData.marketCap, isNull);
      expect(marketData.lastUpdated, isNull);
    });

    test('should handle numeric types correctly', () {
      final json = {
        'symbol': 'ETH/USD',
        'price': 2650,
        'change24h': -1.2,
        'changePercent24h': -1.2,
        'volume': 850000000,
      };

      final marketData = MarketData.fromJson(json);

      expect(marketData.price, 2650.0);
      expect(marketData.change24h, -1.2);
      expect(marketData.changePercent24h, -1.2);
    });
  });
}
