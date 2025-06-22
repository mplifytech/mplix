import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

extension ExScreenMetrics on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  double get width => mq.size.width;
  double get height => mq.size.height;
}

extension ExTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension ExSnackbar on BuildContext {
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: Text(message), duration: duration));
  }
}

extension ExLoader on BuildContext {
  void showLoader({String message = 'Loading...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder:
          (_) => Center(
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

  void hideLoader() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}

extension ExDivider on BuildContext {
  Widget get divider => Divider(color: theme.dividerColor);

  Widget spacing([double height = 10]) => SizedBox(height: height);
}
