import 'package:intl/intl.dart';

/// Formatting helpers for currency, percentages, hours, and square footage.
class CurrencyFormatter {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final NumberFormat _currencyFormatCompact = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat _numberFormat = NumberFormat('#,##0');
  static final NumberFormat _decimalFormat = NumberFormat('#,##0.00');
  static final NumberFormat _oneDecimalFormat = NumberFormat('#,##0.0');

  /// Formats currency with cents: e.g. $1,250.50
  static String formatCurrency(double amount) {
    if (amount.isNaN || amount.isInfinite) return '\$0.00';
    return _currencyFormat.format(amount);
  }

  /// Formats rounded currency without cents: e.g. $1,250
  static String formatCurrencyRounded(double amount) {
    if (amount.isNaN || amount.isInfinite) return '\$0';
    return _currencyFormatCompact.format(amount);
  }

  /// Formats number with commas: e.g. 15,000
  static String formatNumber(num number) {
    return _numberFormat.format(number);
  }

  /// Formats decimal number: e.g. 12.50
  static String formatDecimal(double number) {
    if (number.isNaN || number.isInfinite) return '0.00';
    return _decimalFormat.format(number);
  }

  /// Formats labor hours: e.g. 4.5 hrs
  static String formatHours(double hours) {
    if (hours.isNaN || hours.isInfinite) return '0.0 hrs';
    return '${_oneDecimalFormat.format(hours)} hrs';
  }

  /// Formats percentage: e.g. 40.0%
  static String formatPercent(double percent) {
    if (percent.isNaN || percent.isInfinite) return '0.0%';
    // If passed as decimal fraction 0.40 -> 40.0%
    final double value = percent <= 1.0 && percent > 0.0 ? percent * 100.0 : percent;
    return '${_oneDecimalFormat.format(value)}%';
  }

  /// Formats sq ft: e.g. 12,500 sq ft
  static String formatSqFt(double sqft) {
    return '${_numberFormat.format(sqft)} sq ft';
  }
}
