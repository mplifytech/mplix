import 'package:flutter/material.dart';

extension ExColor on Color {
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${(a.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(r.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(g.toInt()).toRadixString(16).padLeft(2, '0')}'
        '${(b.toInt()).toRadixString(16).padLeft(2, '0')}';
  }
}
