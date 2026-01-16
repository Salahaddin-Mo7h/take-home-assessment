import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../core/errors/app_exceptions.dart';

/// Service for making API calls to the backend
/// 
/// Handles all HTTP requests and provides proper error handling
/// with custom exception types for better error recovery.
class ApiService {
  static const String baseUrl = AppConstants.baseUrl;
  
  /// Fetches market data from the API
  /// 
  /// Returns a list of market data items or throws an [ApiException]
  /// if the request fails.
  Future<List<Map<String, dynamic>>> getMarketData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.marketDataEndpoint}'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw const NetworkException('Request timeout');
        },
      );

      if (response.statusCode == 200) {
        try {
          final jsonData = json.decode(response.body) as Map<String, dynamic>;
          
          if (jsonData['success'] == true && jsonData['data'] != null) {
            return List<Map<String, dynamic>>.from(jsonData['data'] as List);
          } else {
            throw ApiException(
              'Invalid response format',
              statusCode: response.statusCode,
            );
          }
        } catch (e) {
          if (e is ApiException) rethrow;
          throw DataParsingException(
            'Failed to parse response: $e',
            originalError: e,
          );
        }
      } else {
        throw ApiException(
          'Failed to load market data',
          statusCode: response.statusCode,
          code: 'HTTP_${response.statusCode}',
        );
      }
    } on NetworkException {
      rethrow;
    } on ApiException {
      rethrow;
    } on DataParsingException {
      rethrow;
    } catch (e) {
      if (e is http.ClientException) {
        throw NetworkException(
          'Network error: ${e.message}',
          originalError: e,
        );
      }
      throw ApiException(
        'Unexpected error: $e',
        originalError: e,
      );
    }
  }

  Future<Map<String, dynamic>> getAnalyticsOverview() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.analyticsEndpoint}/overview'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load analytics overview: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching analytics overview: $e');
    }
  }

  Future<Map<String, dynamic>> getAnalyticsTrends(String timeframe) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.analyticsEndpoint}/trends?timeframe=$timeframe'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load analytics trends: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching analytics trends: $e');
    }
  }

  Future<Map<String, dynamic>> getAnalyticsSentiment() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.analyticsEndpoint}/sentiment'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load analytics sentiment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching analytics sentiment: $e');
    }
  }

  Future<Map<String, dynamic>> getPortfolioSummary() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load portfolio summary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching portfolio summary: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPortfolioHoldings() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}/holdings'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return List<Map<String, dynamic>>.from(jsonData['data'] as List);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load portfolio holdings: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching portfolio holdings: $e');
    }
  }

  Future<Map<String, dynamic>> getPortfolioPerformance(String timeframe) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}/performance?timeframe=$timeframe'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load portfolio performance: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching portfolio performance: $e');
    }
  }

  Future<Map<String, dynamic>> addTransaction(Map<String, dynamic> transaction) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${AppConstants.portfolioEndpoint}/transactions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaction),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] != null) {
          return jsonData['data'] as Map<String, dynamic>;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to add transaction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding transaction: $e');
    }
  }
}
