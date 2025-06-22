import 'package:flutter/material.dart';
import 'package:mplix/src/context_extensions.dart';

/// Extension on [BuildContext] to simplify navigation operations.
extension ExNavigator on BuildContext {
  /// Pushes a new [page] onto the navigation stack.
  ///
  /// Equivalent to:
  /// ```dart
  /// Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  /// ```
  void push(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));

  /// Replaces the current page with a new [page].
  ///
  /// Equivalent to:
  /// ```dart
  /// Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  /// ```
  void pushReplacement(Widget page) =>
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));

  /// Pops the top-most route off the navigator.
  ///
  /// Optionally returns a [result] to the previous page.
  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);
}

/// Extension on [BuildContext] to handle showing a loader during async operations.
extension ExFutureDialog on BuildContext {
  /// Shows a loader dialog with [message], runs the [future], and hides the loader once done.
  ///
  /// Returns the result of the [future].
  ///
  /// Example:
  /// ```dart
  /// context.withLoadingDialog(Future.delayed(Duration(seconds: 2)));
  /// ```
  Future<T> withLoadingDialog<T>(
      Future<T> future, {
        String message = "Loading...",
      }) async {
    showLoader(message: message);
    try {
      return await future;
    } finally {
      hideLoader();
    }
  }
}
