import 'package:flutter/material.dart';

/// Extension on [Widget] to provide a `.onTap()` method for adding tap handlers.
extension ExTapExtension on Widget {
  /// Wraps the widget in a [GestureDetector] that calls [onTap] when tapped.
  ///
  /// Example:
  /// ```dart
  /// Text('Tap me').onTap(() => print('Tapped!'));
  /// ```
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

/// Extension on [Widget] for adding padding.
extension ExPadding on Widget {
  /// Applies equal padding on all sides.
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Applies horizontal and vertical symmetric padding.
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Applies padding to specific sides.
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

/// Extension on [Iterable] to provide indexed mapping.
extension ExIndexedMap<E> on Iterable<E> {
  /// Maps each element with its index.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'b'].mapIndexed((i, v) => '$i: $v'); // ['0: a', '1: b']
  /// ```
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

/// Extension on [num] to easily create spacing widgets.
extension ExSpacing on num {
  /// Returns a vertical [SizedBox] with the given height.
  SizedBox spacingY() => SizedBox(height: toDouble());

  /// Returns a horizontal [SizedBox] with the given width.
  SizedBox spacingX() => SizedBox(width: toDouble());
}

/// Extension on [double] to convert into [EdgeInsets].
extension ExEdgeInsets on double {
  /// Returns [EdgeInsets.all] with this value.
  EdgeInsets get toAll => EdgeInsets.all(this);

  /// Returns [EdgeInsets.symmetric] with this value used for both vertical and horizontal.
  EdgeInsets get toSymmetric =>
      EdgeInsets.symmetric(vertical: this, horizontal: this);
}

/// Extension to add simple debug logging to any object.
extension ExDebugLog on Object {
  /// Prints the object using `debugPrint()` in debug mode only.
  ///
  /// Optionally adds a [tag] prefix in square brackets.
  ///
  /// Example:
  /// ```dart
  /// 'Something went wrong'.log(tag: 'ERROR');
  /// // Output: [ERROR] Something went wrong
  /// ```
  void log({String tag = ''}) {
    assert(() {
      debugPrint('${tag.isNotEmpty ? '[$tag] ' : ''}$this');
      return true;
    }());
  }
}
