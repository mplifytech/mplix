import 'package:flutter/material.dart';

extension ExTapExtension on Widget {
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

extension ExPadding on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );
}

extension ExIndexedMap<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

extension ExSpacing on num {
  SizedBox spacingY() => SizedBox(height: toDouble());
  SizedBox spacingX() => SizedBox(width: toDouble());
}

extension ExEdgeInsets on double {
  EdgeInsets get toAll => EdgeInsets.all(this);
  EdgeInsets get toSymmetric =>
      EdgeInsets.symmetric(vertical: this, horizontal: this);
}

extension ExDebugLog on Object {
  void log({String tag = ''}) {
    assert(() {
      debugPrint('${tag.isNotEmpty ? '[$tag] ' : ''}$this');
      return true;
    }());
  }
}
