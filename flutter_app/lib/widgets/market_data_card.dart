import 'package:flutter/material.dart';
import '../models/market_data_model.dart';

class MarketDataCard extends StatelessWidget {
  final MarketData marketData;
  final String Function(double) formatCurrency;
  final String Function(double) formatPercent;
  final Color Function(double) getChangeColor;
  final VoidCallback onTap;

  const MarketDataCard({
    super.key,
    required this.marketData,
    required this.formatCurrency,
    required this.formatPercent,
    required this.getChangeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = getChangeColor(marketData.change24h);
    final isPositive = marketData.change24h >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      marketData.symbol,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatCurrency(marketData.price),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: changeColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatPercent(marketData.changePercent24h),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: changeColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          formatCurrency(marketData.change24h.abs()),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

