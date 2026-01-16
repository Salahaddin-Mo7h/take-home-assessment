import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../core/strings/app_strings.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showThemeToggle;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showThemeToggle = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = showThemeToggle
        ? Provider.of<ThemeProvider>(context, listen: false)
        : null;

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      centerTitle: false,
      actions: [
        if (showThemeToggle && themeProvider != null)
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: AppStrings.toggleTheme,
          ),
        if (actions != null) ...actions!,
      ],
    );
  }
}
