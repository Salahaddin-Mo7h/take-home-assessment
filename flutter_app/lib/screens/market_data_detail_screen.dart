import 'package:flutter/material.dart';
import '../models/market_data_model.dart';
import '../widgets/price_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/app_bar_widget.dart';
import '../utils/formatters.dart';
import '../core/strings/app_strings.dart';

class MarketDataDetailScreen extends StatelessWidget {
  final MarketData marketData;

  const MarketDataDetailScreen({
    super.key,
    required this.marketData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: marketData.symbol,
        showThemeToggle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceCard(marketData: marketData),
            const SizedBox(height: 24),
            Text(
              AppStrings.statistics,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            StatCard(
              label: AppStrings.high24h,
              value: marketData.high24h != null
                  ? Formatters.formatCurrency(marketData.high24h!)
                  : AppStrings.notAvailable,
              icon: Icons.arrow_upward,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            StatCard(
              label: AppStrings.low24h,
              value: marketData.low24h != null
                  ? Formatters.formatCurrency(marketData.low24h!)
                  : AppStrings.notAvailable,
              icon: Icons.arrow_downward,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            StatCard(
              label: AppStrings.volume24h,
              value: Formatters.formatLargeNumber(marketData.volume),
              icon: Icons.swap_vert,
              color: Colors.blue,
            ),
            if (marketData.marketCap != null) ...[
              const SizedBox(height: 12),
              StatCard(
                label: AppStrings.marketCap,
                value: Formatters.formatLargeNumber(marketData.marketCap!),
                icon: Icons.account_balance,
                color: Colors.purple,
              ),
            ],
            if (marketData.lastUpdated != null) ...[
              const SizedBox(height: 24),
              Text(
                AppStrings.lastUpdated,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                Formatters.formatTimestamp(marketData.lastUpdated!),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
