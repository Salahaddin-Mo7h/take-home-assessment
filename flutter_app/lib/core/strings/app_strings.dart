class AppStrings {
  AppStrings._();

  static const String appName = 'PulseNow';
  
  static const String searchSymbolsHint = 'Search symbols...';
  static const String sortTooltip = 'Sort';
  static const String sortBy = 'Sort by';
  
  static const String errorLoadingMarketData = 'Error loading market data';
  static const String retry = 'Retry';
  static const String refresh = 'Refresh';
  
  static const String noMarketDataAvailable = 'No market data available';
  
  static const String statistics = 'Statistics';
  static const String lastUpdated = 'Last Updated';
  
  static const String high24h = '24h High';
  static const String low24h = '24h Low';
  static const String volume24h = '24h Volume';
  static const String marketCap = 'Market Cap';
  
  static const String notAvailable = 'N/A';
  
  static const String toggleTheme = 'Toggle theme';
  
  static const String networkError = 'Network error. Please check your connection.';
  static const String dataParsingError = 'Data parsing error. Please try again.';
  static String apiError(String message) => 'API error: $message';
}
