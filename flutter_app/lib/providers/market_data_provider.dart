import 'dart:async';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/websocket_service.dart';
import '../models/market_data_model.dart';
import '../core/cache/cache_service.dart';
import '../core/errors/app_exceptions.dart';
import '../core/enums/sort_option.dart';

/// Provider for managing market data state
/// 
/// Handles:
/// - Loading market data from API
/// - Caching data for offline support
/// - Real-time updates via WebSocket
/// - Search and filtering
/// - Sorting
class MarketDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final WebSocketService _webSocketService = WebSocketService();
  final CacheService _cacheService = CacheService();
  
  List<MarketData> _marketData = [];
  List<MarketData> _filteredMarketData = [];
  bool _isLoading = false;
  bool _isLoadingFromCache = false;
  AppException? _error;
  StreamSubscription<Map<String, dynamic>>? _webSocketSubscription;
  
  String _searchQuery = '';
  SortOption _sortOption = SortOption.symbol;
  bool _sortAscending = true;
  
  List<MarketData> get marketData => _filteredMarketData;
  List<MarketData> get allMarketData => _marketData;
  bool get isLoading => _isLoading;
  bool get isLoadingFromCache => _isLoadingFromCache;
  AppException? get error => _error;
  bool get isWebSocketConnected => _webSocketService.isConnected;
  String get searchQuery => _searchQuery;
  SortOption get sortOption => _sortOption;
  bool get sortAscending => _sortAscending;
  
  MarketDataProvider() {
    _initializeWebSocket();
  }
  
  /// Initialize WebSocket connection for real-time updates
  void _initializeWebSocket() {
    _webSocketService.connect();
    
    _webSocketSubscription = _webSocketService.stream?.listen(
      (data) {
        _handleWebSocketUpdate(data);
      },
      onError: (error) {
        debugPrint('WebSocket error: $error');
      },
    );
  }
  
  /// Handle incoming WebSocket updates
  void _handleWebSocketUpdate(Map<String, dynamic> update) {
    if (update['type'] == 'market_update' && update['data'] != null) {
      final updateData = update['data'] as Map<String, dynamic>;
      final symbol = updateData['symbol'] as String?;
      
      if (symbol != null) {
        final index = _marketData.indexWhere((item) => item.symbol == symbol);
        
        if (index != -1) {
          final existing = _marketData[index];
          final newPrice = (updateData['price'] as num?)?.toDouble() ?? existing.price;
          final newChange24h = (updateData['change24h'] as num?)?.toDouble() ?? existing.change24h;
          final newChangePercent24h = (updateData['changePercent24h'] as num?)?.toDouble() ?? 
                                     (updateData['change24h'] as num?)?.toDouble() ?? 
                                     existing.changePercent24h;
          
          _marketData[index] = MarketData(
            symbol: existing.symbol,
            price: newPrice,
            change24h: newChange24h,
            changePercent24h: newChangePercent24h,
            volume: (updateData['volume'] as num?)?.toDouble() ?? existing.volume,
            high24h: existing.high24h,
            low24h: existing.low24h,
            marketCap: existing.marketCap,
            lastUpdated: updateData['timestamp'] as String? ?? existing.lastUpdated,
          );
          
          _applyFilters();
          notifyListeners();
        }
      }
    }
  }
  
  /// Load market data from API with caching support
  Future<void> loadMarketData({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      _isLoadingFromCache = true;
      notifyListeners();
      
      final cachedData = await _cacheService.getCachedMarketData();
      if (cachedData != null && cachedData.isNotEmpty) {
        try {
          _marketData = cachedData
              .map((json) => MarketData.fromJson(json))
              .toList();
          _applyFilters();
          _isLoadingFromCache = false;
          notifyListeners();
        } catch (e) {
          debugPrint('Error parsing cached data: $e');
        }
      }
      _isLoadingFromCache = false;
    }
    
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final data = await _apiService.getMarketData();
      _marketData = data.map((json) => MarketData.fromJson(json)).toList();
      
      await _cacheService.cacheMarketData(data);
      _applyFilters();
      
      if (!_webSocketService.isConnected) {
        _initializeWebSocket();
      }
    } on AppException catch (e) {
      _error = e;
      if (_marketData.isEmpty) {
        notifyListeners();
      }
    } catch (e) {
      _error = ApiException(
        'Unexpected error: $e',
        originalError: e,
      );
      if (_marketData.isEmpty) {
        notifyListeners();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Set search query and filter results
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }
  
  /// Set sort option
  void setSortOption(SortOption option, {bool? ascending}) {
    final wasSameOption = _sortOption == option;
    _sortOption = option;
    if (ascending != null) {
      _sortAscending = ascending;
    } else {
      if (wasSameOption) {
        _sortAscending = !_sortAscending;
      } else {
        _sortAscending = true;
      }
    }
    _applyFilters();
    notifyListeners();
  }
  
  /// Apply search filter and sorting
  void _applyFilters() {
    var filtered = List<MarketData>.from(_marketData);
    
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((item) {
        return item.symbol.toLowerCase().contains(query);
      }).toList();
    }
    
    filtered.sort((a, b) {
      int comparison = 0;
      switch (_sortOption) {
        case SortOption.symbol:
          comparison = a.symbol.compareTo(b.symbol);
          break;
        case SortOption.price:
          comparison = a.price.compareTo(b.price);
          break;
        case SortOption.change24h:
          comparison = a.change24h.compareTo(b.change24h);
          break;
        case SortOption.changePercent24h:
          comparison = a.changePercent24h.compareTo(b.changePercent24h);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });
    
    _filteredMarketData = filtered;
  }
  
  /// Clear search and reset filters
  void clearFilters() {
    _searchQuery = '';
    _sortOption = SortOption.symbol;
    _sortAscending = true;
    _applyFilters();
    notifyListeners();
  }
  
  /// Retry loading data
  Future<void> retry() async {
    await loadMarketData(forceRefresh: true);
  }
  
  /// Disconnect WebSocket
  void disconnectWebSocket() {
    _webSocketSubscription?.cancel();
    _webSocketService.disconnect();
  }
  
  @override
  void dispose() {
    _webSocketSubscription?.cancel();
    _webSocketService.disconnect();
    super.dispose();
  }
}
