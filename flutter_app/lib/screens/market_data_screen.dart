import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';
import '../widgets/market_data_card.dart';
import '../widgets/search_and_sort_bar.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../utils/formatters.dart';
import '../utils/navigation_helpers.dart';
import 'market_data_detail_screen.dart';

class MarketDataScreen extends StatelessWidget {
  const MarketDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingFromCache && provider.marketData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.isLoading && provider.marketData.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.error != null && provider.marketData.isEmpty) {
          return ErrorStateWidget(
            error: provider.error!,
            onRetry: () => provider.retry(),
          );
        }

        if (provider.marketData.isEmpty && !provider.isLoading) {
          return EmptyStateWidget(
            onRefresh: () => provider.loadMarketData(),
          );
        }

        return AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              SearchAndSortBar(provider: provider),
              
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => NavigationHelpers.refreshMarketData(context),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.marketData.length,
                    itemBuilder: (context, index) {
                      final marketData = provider.marketData[index];
                      return MarketDataCard(
                        marketData: marketData,
                        formatCurrency: Formatters.formatCurrency,
                        formatPercent: Formatters.formatPercent,
                        getChangeColor: Formatters.getChangeColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketDataDetailScreen(
                                marketData: marketData,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
