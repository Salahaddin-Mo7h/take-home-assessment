/// Enum for market data sorting options
enum SortOption {
  symbol,
  price,
  change24h,
  changePercent24h,
}

/// Extension to get display names for sort options
extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.symbol:
        return 'Symbol';
      case SortOption.price:
        return 'Price';
      case SortOption.change24h:
        return '24h Change';
      case SortOption.changePercent24h:
        return '24h Change %';
    }
  }
}

