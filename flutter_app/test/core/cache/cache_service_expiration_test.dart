import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pulsenow_flutter/core/cache/cache_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CacheService Expiration Tests', () {
    late CacheService cacheService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      cacheService = CacheService();
    });

    tearDown(() async {
      await cacheService.clearCache();
    });

    test('should return null for expired cache', () async {
      // Cache data with old timestamp (more than 5 minutes ago)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', 
        '[{"symbol":"BTC/USD","price":43250.50}]');
      await prefs.setInt('cache_timestamp', 
        DateTime.now().subtract(const Duration(minutes: 6)).millisecondsSinceEpoch);

      // Should return null because cache is expired
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
    });

    test('should return data for valid cache', () async {
      await cacheService.cacheMarketData([
        {'symbol': 'BTC/USD', 'price': 43250.50}
      ]);
      
      // Should return data immediately (cache is valid)
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);
      expect(cached!.length, 1);
    });

    test('should clear expired cache automatically', () async {
      // Set expired cache manually
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', 
        '[{"symbol":"BTC/USD","price":43250.50}]');
      await prefs.setInt('cache_timestamp', 
        DateTime.now().subtract(const Duration(minutes: 10)).millisecondsSinceEpoch);

      // Getting expired cache should clear it
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);

      // Verify cache was cleared
      final hasCache = await cacheService.hasValidCache();
      expect(hasCache, false);
    });

    test('should handle cache with missing timestamp', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', 
        '[{"symbol":"BTC/USD","price":43250.50}]');
      // Don't set timestamp

      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
    });

    test('should handle cache with missing data', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cache_timestamp', 
        DateTime.now().millisecondsSinceEpoch);
      // Don't set data

      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
    });

    test('should handle cache parsing errors gracefully', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', 'invalid json');
      await prefs.setInt('cache_timestamp', 
        DateTime.now().millisecondsSinceEpoch);

      // Should return null on parsing error
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
    });
  });
}

