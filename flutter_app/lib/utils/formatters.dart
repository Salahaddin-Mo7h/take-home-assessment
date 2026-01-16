import 'package:intl/intl.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class Formatters {
  static String formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
      locale: 'en_US',
    );
    return formatter.format(value);
  }

  static String formatPercent(double value) {
    final sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(2)}%';
  }

  static Color getChangeColor(double change) {
    return change >= 0
        ? const Color(AppConstants.positiveColor)
        : const Color(AppConstants.negativeColor);
  }

  static String formatLargeNumber(double value) {
    if (value >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(2)}B';
    } else if (value >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(2)}M';
    } else if (value >= 1e3) {
      return '\$${(value / 1e3).toStringAsFixed(2)}K';
    }
    return formatCurrency(value);
  }

  static String formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final formatter = DateFormat('MMM dd, yyyy HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return timestamp;
    }
  }
}

