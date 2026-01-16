class PortfolioHolding {
  final String id;
  final String symbol;
  final double quantity;
  final double averagePrice;
  final double currentPrice;
  final double value;
  final double pnl;
  final double pnlPercent;
  final double allocation;
  final String? lastUpdated;

  PortfolioHolding({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.value,
    required this.pnl,
    required this.pnlPercent,
    required this.allocation,
    this.lastUpdated,
  });

  factory PortfolioHolding.fromJson(Map<String, dynamic> json) {
    return PortfolioHolding(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      pnl: (json['pnl'] as num).toDouble(),
      pnlPercent: (json['pnlPercent'] as num).toDouble(),
      allocation: (json['allocation'] as num).toDouble(),
      lastUpdated: json['lastUpdated'] as String?,
    );
  }
}

class PortfolioSummary {
  final String totalValue;
  final String totalPnl;
  final String totalPnlPercent;
  final int totalHoldings;
  final String? lastUpdated;

  PortfolioSummary({
    required this.totalValue,
    required this.totalPnl,
    required this.totalPnlPercent,
    required this.totalHoldings,
    this.lastUpdated,
  });

  factory PortfolioSummary.fromJson(Map<String, dynamic> json) {
    return PortfolioSummary(
      totalValue: json['totalValue'] as String,
      totalPnl: json['totalPnl'] as String,
      totalPnlPercent: json['totalPnlPercent'] as String,
      totalHoldings: json['totalHoldings'] as int,
      lastUpdated: json['lastUpdated'] as String?,
    );
  }
}

class PerformanceDataPoint {
  final String timestamp;
  final double value;
  final String pnl;
  final String pnlPercent;

  PerformanceDataPoint({
    required this.timestamp,
    required this.value,
    required this.pnl,
    required this.pnlPercent,
  });

  factory PerformanceDataPoint.fromJson(Map<String, dynamic> json) {
    return PerformanceDataPoint(
      timestamp: json['timestamp'] as String,
      value: (json['value'] as num).toDouble(),
      pnl: json['pnl'] as String,
      pnlPercent: json['pnlPercent'] as String,
    );
  }
}

class PerformanceSummary {
  final String startValue;
  final String endValue;
  final String totalReturn;

  PerformanceSummary({
    required this.startValue,
    required this.endValue,
    required this.totalReturn,
  });

  factory PerformanceSummary.fromJson(Map<String, dynamic> json) {
    return PerformanceSummary(
      startValue: json['startValue'] as String,
      endValue: json['endValue'] as String,
      totalReturn: json['totalReturn'] as String,
    );
  }
}

class PortfolioPerformance {
  final String timeframe;
  final List<PerformanceDataPoint> data;
  final PerformanceSummary summary;

  PortfolioPerformance({
    required this.timeframe,
    required this.data,
    required this.summary,
  });

  factory PortfolioPerformance.fromJson(Map<String, dynamic> json) {
    return PortfolioPerformance(
      timeframe: json['timeframe'] as String,
      data: (json['data'] as List)
          .map((item) => PerformanceDataPoint.fromJson(item as Map<String, dynamic>))
          .toList(),
      summary: PerformanceSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }
}

class Transaction {
  final String id;
  final String type;
  final String symbol;
  final double quantity;
  final double price;
  final String timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.symbol,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      type: json['type'] as String,
      symbol: json['symbol'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'symbol': symbol,
      'quantity': quantity,
      'price': price,
    };
  }
}
