import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/portfolio_model.dart';

class PortfolioProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  PortfolioSummary? _summary;
  List<PortfolioHolding> _holdings = [];
  PortfolioPerformance? _performance;
  bool _isLoading = false;
  String? _error;

  PortfolioSummary? get summary => _summary;
  List<PortfolioHolding> get holdings => _holdings;
  PortfolioPerformance? get performance => _performance;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPortfolioSummary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getPortfolioSummary();
      _summary = PortfolioSummary.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHoldings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getPortfolioHoldings();
      _holdings =
          response.map((json) => PortfolioHolding.fromJson(json)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPerformance(String timeframe) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getPortfolioPerformance(timeframe);
      _performance = PortfolioPerformance.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.addTransaction(transaction);
      await loadHoldings();
      await loadPortfolioSummary();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
