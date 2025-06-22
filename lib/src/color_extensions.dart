import 'package:flutter/material.dart';

/// Extension on [Color] to convert it to a hexadecimal string.
extension ExColor on Color {
  /// Converts the [Color] into a hexadecimal string representation.
  ///
  /// If [leadingHashSign] is `true` (default), the resulting string will start with `#`.
  ///
  /// Example:
  /// ```dart
  /// Colors.blue.toHex(); // #FF2196F3
  /// Colors.green.toHex(leadingHashSign: false); // FF4CAF50
  /// ```
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${(a.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(r.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(g.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(b.toInt()).toRadixString(16).padLeft(2, '0')}';
  }
}
