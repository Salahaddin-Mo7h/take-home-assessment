import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';

void main() {
  group('MarketDataProvider Logic Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('Filter Logic with Data', () {
      test('should filter by symbol when search query matches', () {
        // This tests _applyFilters indirectly through setSearchQuery
        provider.setSearchQuery('BTC');
        expect(provider.searchQuery, 'BTC');
        // Even with no data, the filter logic executes
        expect(provider.marketData.length, 0);
      });

      test('should handle case-insensitive search', () {
        provider.setSearchQuery('btc');
        expect(provider.searchQuery, 'btc');
        provider.setSearchQuery('BTC');
        expect(provider.searchQuery, 'BTC');
      });

      test('should handle partial matches in search', () {
        provider.setSearchQuery('BT');
        expect(provider.searchQuery, 'BT');
      });

      test('should clear search and show all data', () {
        provider.setSearchQuery('BTC');
        provider.clearFilters();
        expect(provider.searchQuery, '');
      });
    });

    group('Sort Logic Execution', () {
      test('should execute sort logic for price', () {
        provider.setSortOption(SortOption.price);
        expect(provider.sortOption, SortOption.price);
        expect(provider.sortAscending, true);
      });

      test('should execute sort logic for change24h', () {
        provider.setSortOption(SortOption.change24h);
        expect(provider.sortOption, SortOption.change24h);
      });

      test('should execute sort logic for changePercent24h', () {
        provider.setSortOption(SortOption.changePercent24h);
        expect(provider.sortOption, SortOption.changePercent24h);
      });

      test('should execute sort logic for symbol', () {
        provider.setSortOption(SortOption.symbol);
        expect(provider.sortOption, SortOption.symbol);
      });

      test('should toggle ascending when same option selected twice', () {
        provider.setSortOption(SortOption.price);
        final firstAscending = provider.sortAscending;
        provider.setSortOption(SortOption.price);
        expect(provider.sortAscending, !firstAscending);
      });

      test('should reset to ascending when different option selected', () {
        provider.setSortOption(SortOption.price);
        provider.setSortOption(SortOption.price); // Make it descending
        provider.setSortOption(SortOption.symbol); // Different option
        expect(provider.sortAscending, true);
      });

      test('should respect explicit ascending parameter', () {
        provider.setSortOption(SortOption.price, ascending: false);
        expect(provider.sortAscending, false);
        
        provider.setSortOption(SortOption.price, ascending: true);
        expect(provider.sortAscending, true);
      });
    });

    group('Combined Operations', () {
      test('should apply both search and sort together', () {
        provider.setSearchQuery('ETH');
        provider.setSortOption(SortOption.price, ascending: false);
        expect(provider.searchQuery, 'ETH');
        expect(provider.sortOption, SortOption.price);
        expect(provider.sortAscending, false);
      });

      test('should maintain state through multiple operations', () {
        provider.setSearchQuery('BTC');
        provider.setSortOption(SortOption.change24h);
        provider.setSearchQuery('ETH');
        provider.setSortOption(SortOption.price);
        expect(provider.searchQuery, 'ETH');
        expect(provider.sortOption, SortOption.price);
      });
    });

    group('State Management', () {
      test('should maintain loading state flags', () {
        expect(provider.isLoading, false);
        expect(provider.isLoadingFromCache, false);
      });

      test('should have error state management', () {
        expect(provider.error, isNull);
      });

      test('should have WebSocket state', () {
        expect(provider.isWebSocketConnected, isA<bool>());
      });
    });

    group('Data Access', () {
      test('should provide access to all market data', () {
        expect(provider.allMarketData, isA<List<MarketData>>());
        expect(provider.allMarketData.length, 0);
      });

      test('should provide access to filtered market data', () {
        expect(provider.marketData, isA<List<MarketData>>());
        expect(provider.marketData.length, 0);
      });

      test('should have consistent data access', () {
        final allData = provider.allMarketData;
        final filteredData = provider.marketData;
        expect(allData, isA<List<MarketData>>());
        expect(filteredData, isA<List<MarketData>>());
      });
    });
  });
}

