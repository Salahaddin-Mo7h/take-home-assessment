import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/providers/market_data_provider.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';
import 'package:pulsenow_flutter/models/market_data_model.dart';

void main() {
  group('MarketDataProvider', () {
    late MarketDataProvider provider;

    setUp(() {
      provider = MarketDataProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('should initialize with empty market data', () {
      // Assert
      expect(provider.marketData, isEmpty);
      expect(provider.isLoading, false);
      expect(provider.error, isNull);
      expect(provider.isLoadingFromCache, false);
    });

    test('should initialize with default search and sort', () {
      // Assert
      expect(provider.searchQuery, '');
      expect(provider.sortOption, SortOption.symbol);
      expect(provider.sortAscending, true);
    });

    group('Search functionality', () {
      test('should update search query', () {
        // Act
        provider.setSearchQuery('BTC');

        // Assert
        expect(provider.searchQuery, 'BTC');
      });

      test('should clear search query', () {
        // Arrange
        provider.setSearchQuery('BTC');

        // Act
        provider.setSearchQuery('');

        // Assert
        expect(provider.searchQuery, '');
      });

      test('should handle empty search query', () {
        // Act
        provider.setSearchQuery('');

        // Assert
        expect(provider.searchQuery, '');
      });
    });

    group('Sort functionality', () {
      test('should set sort option to price', () {
        // Act
        provider.setSortOption(SortOption.price);

        // Assert
        expect(provider.sortOption, SortOption.price);
        expect(provider.sortAscending, true);
      });

      test('should set sort option to change24h', () {
        // Act
        provider.setSortOption(SortOption.change24h);

        // Assert
        expect(provider.sortOption, SortOption.change24h);
      });

      test('should set sort option to changePercent24h', () {
        // Act
        provider.setSortOption(SortOption.changePercent24h);

        // Assert
        expect(provider.sortOption, SortOption.changePercent24h);
      });

      test('should toggle sort ascending when same option selected', () {
        // Arrange
        provider.setSortOption(SortOption.price);
        final initialAscending = provider.sortAscending;

        // Act
        provider.setSortOption(SortOption.price);

        // Assert
        expect(provider.sortAscending, !initialAscending);
      });

      test('should set ascending to true when different option selected', () {
        // Arrange
        provider.setSortOption(SortOption.price);
        provider.setSortOption(SortOption.price); // Make it descending

        // Act
        provider.setSortOption(SortOption.symbol);

        // Assert
        expect(provider.sortAscending, true);
      });

      test('should allow explicit ascending parameter', () {
        // Act
        provider.setSortOption(SortOption.price, ascending: false);

        // Assert
        expect(provider.sortOption, SortOption.price);
        expect(provider.sortAscending, false);
      });
    });

    group('Filter clearing', () {
      test('should clear all filters', () {
        // Arrange
        provider.setSearchQuery('BTC');
        provider.setSortOption(SortOption.price);

        // Act
        provider.clearFilters();

        // Assert
        expect(provider.searchQuery, '');
        expect(provider.sortOption, SortOption.symbol);
        expect(provider.sortAscending, true);
      });

      test('should reset to defaults when clearing filters', () {
        // Arrange
        provider.setSearchQuery('ETH');
        provider.setSortOption(SortOption.change24h, ascending: false);

        // Act
        provider.clearFilters();

        // Assert
        expect(provider.searchQuery, '');
        expect(provider.sortOption, SortOption.symbol);
        expect(provider.sortAscending, true);
      });
    });

    group('Methods', () {
      test('should have loadMarketData method', () {
        // Assert
        expect(provider.loadMarketData, isA<Function>());
      });

      test('should have retry method', () {
        // Assert
        expect(provider.retry, isA<Function>());
      });

      test('should have disconnectWebSocket method', () {
        // Assert
        expect(provider.disconnectWebSocket, isA<Function>());
      });
    });

    group('Getters', () {
      test('should have allMarketData getter', () {
        // Assert
        expect(provider.allMarketData, isA<List<MarketData>>());
      });

      test('should have marketData getter', () {
        // Assert
        expect(provider.marketData, isA<List<MarketData>>());
      });

      test('should have isLoading getter', () {
        // Assert
        expect(provider.isLoading, isA<bool>());
      });

      test('should have isLoadingFromCache getter', () {
        // Assert
        expect(provider.isLoadingFromCache, isA<bool>());
      });

      test('should have error getter', () {
        // Assert
        expect(provider.error, anything);
      });

      test('should have isWebSocketConnected getter', () {
        // Assert
        expect(provider.isWebSocketConnected, isA<bool>());
      });
    });
  });
}
