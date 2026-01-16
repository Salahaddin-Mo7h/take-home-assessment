import 'package:flutter/material.dart';
import '../models/market_data_model.dart';
import '../utils/formatters.dart';

class PriceCard extends StatelessWidget {
  final MarketData marketData;

  const PriceCard({
    super.key,
    required this.marketData,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = Formatters.getChangeColor(marketData.change24h);
    final isPositive = marketData.change24h >= 0;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              Formatters.formatCurrency(marketData.price),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: changeColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  Formatters.formatPercent(marketData.changePercent24h),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: changeColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${Formatters.formatCurrency(marketData.change24h.abs())})',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
