import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../errors/app_exceptions.dart';

/// Service for caching data locally
/// 
/// Provides methods to cache and retrieve data from local storage
/// for offline support and improved performance.
class CacheService {
  static const String _marketDataKey = 'cached_market_data';
  static const String _cacheTimestampKey = 'cache_timestamp';
  static const Duration _cacheValidityDuration = Duration(minutes: 5);

  /// Cache market data locally
  Future<void> cacheMarketData(List<Map<String, dynamic>> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(data);
      await prefs.setString(_marketDataKey, jsonString);
      await prefs.setInt(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      throw CacheException(
        'Failed to cache market data: $e',
        originalError: e,
      );
    }
  }

  /// Retrieve cached market data if available and not expired
  Future<List<Map<String, dynamic>>?> getCachedMarketData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_marketDataKey);
      final timestamp = prefs.getInt(_cacheTimestampKey);

      if (cachedData == null || timestamp == null) {
        return null;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      if (now.difference(cacheTime) > _cacheValidityDuration) {
        await clearCache();
        return null;
      }

      final data = json.decode(cachedData) as List;
      return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>),
      );
    } catch (e) {
      debugPrint('Error reading cache: $e');
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_marketDataKey);
      await prefs.remove(_cacheTimestampKey);
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Check if cache is available and valid
  Future<bool> hasValidCache() async {
    final cachedData = await getCachedMarketData();
    return cachedData != null;
  }
}

