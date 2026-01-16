import 'package:flutter/material.dart';
import '../providers/market_data_provider.dart';
import '../utils/navigation_helpers.dart';
import '../core/strings/app_strings.dart';

class SearchAndSortBar extends StatefulWidget {
  final MarketDataProvider provider;

  const SearchAndSortBar({
    super.key,
    required this.provider,
  });

  @override
  State<SearchAndSortBar> createState() => _SearchAndSortBarState();
}

class _SearchAndSortBarState extends State<SearchAndSortBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      widget.provider.setSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchSymbolsHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              widget.provider.clearFilters();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => NavigationHelpers.showSortDialog(context, widget.provider),
            tooltip: AppStrings.sortTooltip,
          ),
        ],
      ),
    );
  }
}
