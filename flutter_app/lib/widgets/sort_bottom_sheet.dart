import 'package:flutter/material.dart';
import '../core/enums/sort_option.dart';
import '../core/strings/app_strings.dart';

class SortBottomSheet extends StatelessWidget {
  final SortOption currentSort;
  final bool ascending;
  final Function(SortOption, bool) onSortSelected;

  const SortBottomSheet({
    super.key,
    required this.currentSort,
    required this.ascending,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.sortBy,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ...SortOption.values.map((option) {
            final isSelected = currentSort == option;
            return ListTile(
              title: Text(option.displayName),
              leading: Radio<SortOption>(
                value: option,
                groupValue: currentSort,
                onChanged: (value) {
                  if (value != null) {
                    onSortSelected(value, ascending);
                  }
                },
              ),
              trailing: isSelected
                  ? IconButton(
                      icon: Icon(ascending ? Icons.arrow_upward : Icons.arrow_downward),
                      onPressed: () {
                        onSortSelected(option, !ascending);
                      },
                    )
                  : null,
              onTap: () {
                if (isSelected) {
                  onSortSelected(option, !ascending);
                } else {
                  onSortSelected(option, true);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
