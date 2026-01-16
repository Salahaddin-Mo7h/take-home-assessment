class MarketLeader {
  final String symbol;
  final double change;
  final double price;

  MarketLeader({
    required this.symbol,
    required this.change,
    required this.price,
  });

  factory MarketLeader.fromJson(Map<String, dynamic> json) {
    return MarketLeader(
      symbol: json['symbol'] as String,
      change: (json['change'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
    );
  }
}

class MarketDominance {
  final double btc;
  final double eth;
  final double others;

  MarketDominance({
    required this.btc,
    required this.eth,
    required this.others,
  });

  factory MarketDominance.fromJson(Map<String, dynamic> json) {
    return MarketDominance(
      btc: (json['btc'] as num).toDouble(),
      eth: (json['eth'] as num).toDouble(),
      others: (json['others'] as num).toDouble(),
    );
  }
}

class AnalyticsOverview {
  final double totalMarketCap;
  final double totalVolume24h;
  final int activeMarkets;
  final MarketLeader topGainer;
  final MarketLeader topLoser;
  final MarketDominance marketDominance;
  final String? lastUpdated;

  AnalyticsOverview({
    required this.totalMarketCap,
    required this.totalVolume24h,
    required this.activeMarkets,
    required this.topGainer,
    required this.topLoser,
    required this.marketDominance,
    this.lastUpdated,
  });

  factory AnalyticsOverview.fromJson(Map<String, dynamic> json) {
    return AnalyticsOverview(
      totalMarketCap: (json['totalMarketCap'] as num).toDouble(),
      totalVolume24h: (json['totalVolume24h'] as num).toDouble(),
      activeMarkets: json['activeMarkets'] as int,
      topGainer: MarketLeader.fromJson(json['topGainer'] as Map<String, dynamic>),
      topLoser: MarketLeader.fromJson(json['topLoser'] as Map<String, dynamic>),
      marketDominance: MarketDominance.fromJson(json['marketDominance'] as Map<String, dynamic>),
      lastUpdated: json['lastUpdated'] as String?,
    );
  }
}

class TrendDataPoint {
  final String timestamp;
  final double marketCap;
  final double volume;
  final double priceIndex;

  TrendDataPoint({
    required this.timestamp,
    required this.marketCap,
    required this.volume,
    required this.priceIndex,
  });

  factory TrendDataPoint.fromJson(Map<String, dynamic> json) {
    return TrendDataPoint(
      timestamp: json['timestamp'] as String,
      marketCap: (json['marketCap'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      priceIndex: (json['priceIndex'] as num).toDouble(),
    );
  }
}

class TrendsSummary {
  final double change;
  final double volatility;

  TrendsSummary({
    required this.change,
    required this.volatility,
  });

  factory TrendsSummary.fromJson(Map<String, dynamic> json) {
    return TrendsSummary(
      change: (json['change'] as num).toDouble(),
      volatility: (json['volatility'] as num).toDouble(),
    );
  }
}

class MarketTrends {
  final String timeframe;
  final List<TrendDataPoint> data;
  final TrendsSummary summary;

  MarketTrends({
    required this.timeframe,
    required this.data,
    required this.summary,
  });

  factory MarketTrends.fromJson(Map<String, dynamic> json) {
    return MarketTrends(
      timeframe: json['timeframe'] as String,
      data: (json['data'] as List)
          .map((item) => TrendDataPoint.fromJson(item as Map<String, dynamic>))
          .toList(),
      summary: TrendsSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }
}

class SentimentOverall {
  final int score;
  final String label;
  final double change24h;

  SentimentOverall({
    required this.score,
    required this.label,
    required this.change24h,
  });

  factory SentimentOverall.fromJson(Map<String, dynamic> json) {
    return SentimentOverall(
      score: json['score'] as int,
      label: json['label'] as String,
      change24h: (json['change24h'] as num).toDouble(),
    );
  }
}

class SentimentIndicators {
  final int fearGreedIndex;
  final int socialSentiment;
  final int technicalAnalysis;
  final int onChainMetrics;

  SentimentIndicators({
    required this.fearGreedIndex,
    required this.socialSentiment,
    required this.technicalAnalysis,
    required this.onChainMetrics,
  });

  factory SentimentIndicators.fromJson(Map<String, dynamic> json) {
    return SentimentIndicators(
      fearGreedIndex: json['fearGreedIndex'] as int,
      socialSentiment: json['socialSentiment'] as int,
      technicalAnalysis: json['technicalAnalysis'] as int,
      onChainMetrics: json['onChainMetrics'] as int,
    );
  }
}

class SentimentBreakdown {
  final String category;
  final int score;
  final double weight;

  SentimentBreakdown({
    required this.category,
    required this.score,
    required this.weight,
  });

  factory SentimentBreakdown.fromJson(Map<String, dynamic> json) {
    return SentimentBreakdown(
      category: json['category'] as String,
      score: json['score'] as int,
      weight: (json['weight'] as num).toDouble(),
    );
  }
}

class MarketSentiment {
  final SentimentOverall overall;
  final SentimentIndicators indicators;
  final List<SentimentBreakdown> breakdown;
  final String? lastUpdated;

  MarketSentiment({
    required this.overall,
    required this.indicators,
    required this.breakdown,
    this.lastUpdated,
  });

  factory MarketSentiment.fromJson(Map<String, dynamic> json) {
    return MarketSentiment(
      overall: SentimentOverall.fromJson(json['overall'] as Map<String, dynamic>),
      indicators: SentimentIndicators.fromJson(json['indicators'] as Map<String, dynamic>),
      breakdown: (json['breakdown'] as List)
          .map((item) => SentimentBreakdown.fromJson(item as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] as String?,
    );
  }
}
