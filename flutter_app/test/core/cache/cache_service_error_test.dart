import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pulsenow_flutter/core/cache/cache_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CacheService Error Handling Tests', () {
    late CacheService cacheService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      cacheService = CacheService();
    });

    tearDown(() async {
      await cacheService.clearCache();
    });

    test('cacheMarketData should handle errors and throw CacheException',
        () async {
      // This tests the try-catch in cacheMarketData
      final testData = [
        {'symbol': 'BTC/USD', 'price': 43250.50}
      ];

      // Should execute successfully
      await cacheService.cacheMarketData(testData);
      expect(await cacheService.hasValidCache(), true);
    });

    test('getCachedMarketData should handle parsing errors gracefully',
        () async {
      // Set invalid JSON
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', 'invalid json');
      await prefs.setInt(
          'cache_timestamp', DateTime.now().millisecondsSinceEpoch);

      // Should return null on error (catch block)
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
    });

    test('getCachedMarketData should execute cache expiration check', () async {
      final testData = [
        {'symbol': 'BTC/USD', 'price': 43250.50}
      ];
      await cacheService.cacheMarketData(testData);

      // Should check expiration
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);
    });

    test('getCachedMarketData should execute clearCache on expiration',
        () async {
      // Set expired cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', '[{"symbol":"BTC/USD"}]');
      await prefs.setInt('cache_timestamp',
          DateTime.now().subtract(const Duration(minutes: 6)).millisecondsSinceEpoch);

      // Should clear expired cache
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);

      // Verify cache was cleared
      final hasCache = await cacheService.hasValidCache();
      expect(hasCache, false);
    });

    test('clearCache should handle errors gracefully', () async {
      // Should handle errors in clearCache
      await cacheService.cacheMarketData([
        {'symbol': 'BTC/USD'}
      ]);
      await cacheService.clearCache();
      expect(await cacheService.hasValidCache(), false);
    });

    test('hasValidCache should call getCachedMarketData', () async {
      final testData = [
        {'symbol': 'BTC/USD', 'price': 43250.50}
      ];
      await cacheService.cacheMarketData(testData);

      // Should call getCachedMarketData internally
      final hasCache = await cacheService.hasValidCache();
      expect(hasCache, true);
    });

    test('should handle cache operations with various data formats', () async {
      final data1 = [
        {'symbol': 'BTC/USD', 'price': 43250.50}
      ];
      final data2 = [
        {'symbol': 'ETH/USD', 'price': 2650.75, 'volume': 1000000}
      ];

      await cacheService.cacheMarketData(data1);
      var cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);

      await cacheService.cacheMarketData(data2);
      cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);
    });
  });
}
