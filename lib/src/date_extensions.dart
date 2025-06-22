import 'package:intl/intl.dart';

/// Extension on [DateTime] for common formatting utilities.
extension ExDateFormat on DateTime {
  /// Formats the date using the provided [pattern].
  ///
  /// Defaults to `'dd MMM yyyy'` (e.g. `22 Jun 2025`).
  ///
  /// Example:
  /// ```dart
  /// DateTime.now().format(); // 22 Jun 2025
  /// DateTime.now().format('yyyy-MM-dd'); // 2025-06-22
  /// ```
  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);

  /// Returns the time formatted as `hh:mm a` (e.g. `08:30 AM`).
  String get time => DateFormat('hh:mm a').format(this);

  /// Returns a short date format `dd/MM/yy` (e.g. `22/06/25`).
  String get short => DateFormat('dd/MM/yy').format(this);

  /// Returns full date-time format `dd MMM yyyy, hh:mm a`.
  ///
  /// Example: `22 Jun 2025, 08:30 AM`
  String get fullDateTime => DateFormat('dd MMM yyyy, hh:mm a').format(this);
}

/// Extension on [Duration] to get formatted time.
extension ExDurationFormat on Duration {
  /// Returns the duration formatted as `mm:ss`.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 75).formatted; // 01:15
  /// ```
  String get formatted =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
}

/// Extension on [DateTime] for date comparisons.
extension ExDateCompare on DateTime {
  /// Returns `true` if this date is the same as [other] (ignores time).
  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns `true` if the date is today.
  bool get isToday => isSameDate(DateTime.now());
}
