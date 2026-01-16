import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/analytics_model.dart';

class AnalyticsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  AnalyticsOverview? _overview;
  MarketTrends? _trends;
  MarketSentiment? _sentiment;
  bool _isLoading = false;
  String? _error;
  
  AnalyticsOverview? get overview => _overview;
  MarketTrends? get trends => _trends;
  MarketSentiment? get sentiment => _sentiment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> loadOverview() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.getAnalyticsOverview();
      _overview = AnalyticsOverview.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTrends(String timeframe) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.getAnalyticsTrends(timeframe);
      _trends = MarketTrends.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSentiment() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.getAnalyticsSentiment();
      _sentiment = MarketSentiment.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
