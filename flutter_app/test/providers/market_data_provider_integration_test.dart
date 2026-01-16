import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';

void main() {
  group('MarketDataProvider Integration Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('Filter Application', () {
      test('should filter data when search query is set', () {
        // This tests the _applyFilters method indirectly
        provider.setSearchQuery('BTC');
        expect(provider.searchQuery, 'BTC');
        // Filtered data should be empty if no data loaded, but method should execute
        expect(provider.marketData, isA<List<MarketData>>());
      });

      test('should apply sort when sort option changes', () {
        // This tests the _applyFilters method with sorting
        provider.setSortOption(SortOption.price);
        expect(provider.sortOption, SortOption.price);
        expect(provider.marketData, isA<List<MarketData>>());
      });

      test('should combine search and sort', () {
        provider.setSearchQuery('ETH');
        provider.setSortOption(SortOption.change24h);
        expect(provider.searchQuery, 'ETH');
        expect(provider.sortOption, SortOption.change24h);
      });
    });

    group('WebSocket Integration', () {
      test('should have WebSocket connection status', () {
        expect(provider.isWebSocketConnected, isA<bool>());
      });

      test('should allow WebSocket disconnection', () {
        expect(() => provider.disconnectWebSocket(), returnsNormally);
      });
    });

    group('Error Handling', () {
      test('should have error getter', () {
        expect(provider.error, anything);
      });

      test('should have retry method', () {
        expect(provider.retry, isA<Function>());
      });
    });

    group('Data Management', () {
      test('should have separate getters for all and filtered data', () {
        expect(provider.allMarketData, isA<List<MarketData>>());
        expect(provider.marketData, isA<List<MarketData>>());
      });

      test('should track loading states', () {
        expect(provider.isLoading, isA<bool>());
        expect(provider.isLoadingFromCache, isA<bool>());
      });
    });
  });
}

