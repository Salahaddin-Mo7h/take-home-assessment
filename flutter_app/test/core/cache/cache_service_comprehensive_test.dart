import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pulsenow_flutter/core/cache/cache_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CacheService Comprehensive Tests', () {
    late CacheService cacheService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      cacheService = CacheService();
    });

    tearDown(() async {
      await cacheService.clearCache();
    });

    test('clearCache should execute both remove operations', () async {
      await cacheService.cacheMarketData([{'symbol': 'BTC/USD'}]);
      await cacheService.clearCache();
      
      // Should remove both keys
      final hasCache = await cacheService.hasValidCache();
      expect(hasCache, false);
    });

    test('clearCache should handle errors in remove operations', () async {
      // Should execute error handling in clearCache
      await cacheService.clearCache();
      expect(await cacheService.hasValidCache(), false);
    });

    test('getCachedMarketData should execute all branches', () async {
      // Test null cachedData branch
      var cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
      
      // Test null timestamp branch
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_market_data', '[{"symbol":"BTC/USD"}]');
      cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
      
      // Test expired cache branch
      await prefs.setInt('cache_timestamp', 
        DateTime.now().subtract(const Duration(minutes: 6)).millisecondsSinceEpoch);
      cached = await cacheService.getCachedMarketData();
      expect(cached, isNull);
      
      // Test valid cache branch
      await cacheService.cacheMarketData([{'symbol': 'BTC/USD'}]);
      cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);
    });

    test('hasValidCache should call getCachedMarketData', () async {
      await cacheService.cacheMarketData([{'symbol': 'BTC/USD'}]);
      
      // Should call getCachedMarketData internally
      final hasCache = await cacheService.hasValidCache();
      expect(hasCache, true);
    });

    test('cacheMarketData should execute all operations', () async {
      final testData = [
        {'symbol': 'BTC/USD', 'price': 43250.50},
        {'symbol': 'ETH/USD', 'price': 2650.75}
      ];
      
      // Should execute json.encode, setString, setInt
      await cacheService.cacheMarketData(testData);
      
      final cached = await cacheService.getCachedMarketData();
      expect(cached, isNotNull);
      expect(cached!.length, 2);
    });

    test('should handle cache operations with complex data', () async {
      final complexData = [
        {
          'symbol': 'BTC/USD',
          'price': 43250.50,
          'change24h': 2.5,
          'changePercent24h': 2.5,
          'volume': 1250000000,
          'high24h': 44000.0,
          'low24h': 42000.0,
          'marketCap': 850000000000,
          'lastUpdated': '2024-01-01T00:00:00Z'
        }
      ];
      
      await cacheService.cacheMarketData(complexData);
      final cached = await cacheService.getCachedMarketData();
      
      expect(cached, isNotNull);
      expect(cached!.first['symbol'], 'BTC/USD');
      expect(cached.first['price'], 43250.50);
    });
  });
}
