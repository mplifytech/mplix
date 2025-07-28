import 'package:intl/intl.dart';

/// Extension on [num] for clean, compact, currency, localized, and ordinal formatting.
extension ExSmartNumberFormat on num {
  /// Returns a string:
  /// - with no decimals if whole number, else 2 decimal places.
  /// Example: 42 → "42", 42.5 → "42.50"
  String toCleanString() =>
      this % 1 == 0 ? toStringAsFixed(0) : toStringAsFixed(2);

  /// Returns formatted compact string: 1000 → "1K", 1500000 → "1.5M"
  String toCompact({String? locale}) =>
      NumberFormat.compact(locale: locale).format(this);

  /// Returns currency formatted string: 1000 → ₹1,000.00 or $1,000.00
  String toCurrency({
    String locale = 'en_IN',
    String? symbol,
    int decimalDigits = 2,
  }) => NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: decimalDigits,
  ).format(this);

  /// Returns localized string with commas, e.g. 1234567 → 12,34,567 in India.
  String toLocalized({String locale = 'en_IN'}) =>
      NumberFormat.decimalPattern(locale).format(this);

  /// Returns ordinal format: 1 → 1st, 2 → 2nd, 3 → 3rd, etc.
  String toOrdinal() {
    final int number = toInt();
    if ((number % 100) >= 11 && (number % 100) <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}
