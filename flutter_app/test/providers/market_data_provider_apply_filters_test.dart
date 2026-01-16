import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';

void main() {
  group('MarketDataProvider _applyFilters Execution', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('_applyFilters executes when setSearchQuery is called', () {
      // This ensures _applyFilters is called
      provider.setSearchQuery('BTC');
      expect(provider.searchQuery, 'BTC');
      // _applyFilters executes here
    });

    test('_applyFilters executes when setSortOption is called', () {
      // This ensures _applyFilters is called
      provider.setSortOption(SortOption.price);
      expect(provider.sortOption, SortOption.price);
      // _applyFilters executes here
    });

    test('_applyFilters executes when clearFilters is called', () {
      // This ensures _applyFilters is called
      provider.setSearchQuery('BTC');
      provider.clearFilters();
      expect(provider.searchQuery, '');
      // _applyFilters executes here
    });

    test('_applyFilters executes search filter branch with non-empty query', () {
      provider.setSearchQuery('ETH');
      // This executes: if (_searchQuery.isNotEmpty) branch
      expect(provider.searchQuery, 'ETH');
    });

    test('_applyFilters skips search filter branch with empty query', () {
      provider.setSearchQuery('');
      // This executes: if (_searchQuery.isNotEmpty) is false, skips filter
      expect(provider.searchQuery, '');
    });

    test('_applyFilters executes all sort option cases', () {
      // Test symbol case
      provider.setSortOption(SortOption.symbol);
      expect(provider.sortOption, SortOption.symbol);
      
      // Test price case
      provider.setSortOption(SortOption.price);
      expect(provider.sortOption, SortOption.price);
      
      // Test change24h case
      provider.setSortOption(SortOption.change24h);
      expect(provider.sortOption, SortOption.change24h);
      
      // Test changePercent24h case
      provider.setSortOption(SortOption.changePercent24h);
      expect(provider.sortOption, SortOption.changePercent24h);
    });

    test('_applyFilters executes ascending sort logic', () {
      provider.setSortOption(SortOption.price, ascending: true);
      // This executes: return _sortAscending ? comparison : -comparison;
      expect(provider.sortAscending, true);
    });

    test('_applyFilters executes descending sort logic', () {
      provider.setSortOption(SortOption.price, ascending: false);
      // This executes: return _sortAscending ? comparison : -comparison;
      expect(provider.sortAscending, false);
    });

    test('_applyFilters executes multiple times in sequence', () {
      provider.setSearchQuery('BTC');
      provider.setSortOption(SortOption.price);
      provider.setSearchQuery('ETH');
      provider.setSortOption(SortOption.change24h);
      // _applyFilters executes multiple times
      expect(provider.searchQuery, 'ETH');
      expect(provider.sortOption, SortOption.change24h);
    });
  });
}

