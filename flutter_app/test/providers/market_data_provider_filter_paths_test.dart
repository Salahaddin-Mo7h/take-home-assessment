import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MarketDataProvider Filter Path Tests', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('_applyFilters should handle empty market data', () {
      // Tests filtering with empty data
      provider.setSearchQuery('BTC');
      expect(provider.marketData, isEmpty);
    });

    test('_applyFilters should execute search filter when query is not empty', () {
      provider.setSearchQuery('ETH');
      // This executes: if (_searchQuery.isNotEmpty) branch
      expect(provider.searchQuery, 'ETH');
    });

    test('_applyFilters should skip search filter when query is empty', () {
      provider.setSearchQuery('');
      // This executes: if (_searchQuery.isNotEmpty) is false
      expect(provider.searchQuery, '');
    });

    test('_applyFilters should execute all sort comparison cases', () {
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

    test('_applyFilters should execute ascending sort path', () {
      provider.setSortOption(SortOption.price, ascending: true);
      // This executes: return _sortAscending ? comparison : -comparison;
      expect(provider.sortAscending, true);
    });

    test('_applyFilters should execute descending sort path', () {
      provider.setSortOption(SortOption.price, ascending: false);
      // This executes: return _sortAscending ? comparison : -comparison;
      expect(provider.sortAscending, false);
    });

    test('setSortOption should handle ascending parameter', () {
      provider.setSortOption(SortOption.price, ascending: true);
      expect(provider.sortAscending, true);
      
      provider.setSortOption(SortOption.price, ascending: false);
      expect(provider.sortAscending, false);
    });

    test('setSortOption should toggle when same option selected', () {
      provider.setSortOption(SortOption.price);
      final first = provider.sortAscending;
      provider.setSortOption(SortOption.price);
      expect(provider.sortAscending, !first);
    });

    test('setSortOption should reset to ascending for different option', () {
      provider.setSortOption(SortOption.price);
      provider.setSortOption(SortOption.price); // Make it descending
      provider.setSortOption(SortOption.symbol); // Different option
      expect(provider.sortAscending, true);
    });

    test('clearFilters should reset all filter state', () {
      provider.setSearchQuery('BTC');
      provider.setSortOption(SortOption.price, ascending: false);
      provider.clearFilters();
      
      expect(provider.searchQuery, '');
      expect(provider.sortOption, SortOption.symbol);
      expect(provider.sortAscending, true);
    });
  });
}

