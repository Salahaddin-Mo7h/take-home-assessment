import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/core/enums/sort_option.dart';

void main() {
  group('SortOption', () {
    test('should have all expected values', () {
      // Assert
      expect(SortOption.values.length, 4);
      expect(SortOption.values, contains(SortOption.symbol));
      expect(SortOption.values, contains(SortOption.price));
      expect(SortOption.values, contains(SortOption.change24h));
      expect(SortOption.values, contains(SortOption.changePercent24h));
    });
  });

  group('SortOptionExtension', () {
    test('should return correct display names', () {
      // Assert
      expect(SortOption.symbol.displayName, 'Symbol');
      expect(SortOption.price.displayName, 'Price');
      expect(SortOption.change24h.displayName, '24h Change');
      expect(SortOption.changePercent24h.displayName, '24h Change %');
    });
  });
}
