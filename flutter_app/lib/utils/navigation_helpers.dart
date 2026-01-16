import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';
import '../widgets/sort_bottom_sheet.dart';

class NavigationHelpers {
  static void showSortDialog(
    BuildContext context,
    MarketDataProvider provider,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SortBottomSheet(
        currentSort: provider.sortOption,
        ascending: provider.sortAscending,
        onSortSelected: (option, ascending) {
          provider.setSortOption(option, ascending: ascending);
          Navigator.pop(context);
        },
      ),
    );
  }

  static Future<void> refreshMarketData(BuildContext context) async {
    await Provider.of<MarketDataProvider>(context, listen: false)
        .loadMarketData(forceRefresh: true);
  }
}

