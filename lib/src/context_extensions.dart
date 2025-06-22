import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Extension on [BuildContext] to simplify access to screen metrics.
extension ExScreenMetrics on BuildContext {
  /// Returns the [MediaQueryData] for this context.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns the screen width.
  double get width => mq.size.width;

  /// Returns the screen height.
  double get height => mq.size.height;
}

/// Extension on [BuildContext] to easily access theme and color data.
extension ExTheme on BuildContext {
  /// Returns the [ThemeData] for this context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [TextTheme] from the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the [ColorScheme] from the current theme.
  ColorScheme get colorScheme => theme.colorScheme;
}

/// Extension on [BuildContext] for showing snackbars easily.
extension ExSnackbar on BuildContext {
  /// Shows a [SnackBar] with the provided [message] and optional [duration].
  ///
  /// Example:
  /// ```dart
  /// context.showSnackbar('This is a message');
  /// ```
  void showSnackbar(
      String message, {
        Duration duration = const Duration(seconds: 2),
      }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }
}

/// Extension on [BuildContext] to show and hide loading dialogs.
extension ExLoader on BuildContext {
  /// Shows a loading dialog with an optional [message].
  ///
  /// Example:
  /// ```dart
  /// context.showLoader(message: 'Please wait...');
  /// ```
  void showLoader({String message = 'Loading...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitRipple(size: 50, color: theme.primaryColor),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
    );
  }

  /// Hides the loading dialog shown using [showLoader].
  void hideLoader() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}

/// Extension on [BuildContext] for common layout widgets like divider and spacing.
extension ExDivider on BuildContext {
  /// Returns a [Divider] using the current theme’s divider color.
  Widget get divider => Divider(color: theme.dividerColor);

  /// Returns a vertical [SizedBox] with the given [height] (default is `10`).
  ///
  /// Example:
  /// ```dart
  /// context.spacing(20); // SizedBox(height: 20)
  /// ```
  Widget spacing([double height = 10]) => SizedBox(height: height);
}
