import 'package:flutter/material.dart';
import 'market_data_screen.dart';
import '../widgets/app_bar_widget.dart';
import '../core/strings/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: AppStrings.appName),
      body: MarketDataScreen(),
    );
  }
}
