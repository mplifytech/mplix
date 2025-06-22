import 'package:intl/intl.dart';

extension ExDateFormat on DateTime {
  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);

  String get time => DateFormat('hh:mm a').format(this);

  String get short => DateFormat('dd/MM/yy').format(this);

  String get fullDateTime => DateFormat('dd MMM yyyy, hh:mm a').format(this);
}

extension ExDurationFormat on Duration {
  String get formatted =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
}

extension ExDateCompare on DateTime {
  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday => isSameDate(DateTime.now());
}
