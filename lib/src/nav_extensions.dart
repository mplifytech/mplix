import 'package:flutter/material.dart';
import 'package:mplix/src/context_extensions.dart';

extension ExNavigator on BuildContext {
  void push(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));

  void pushReplacement(Widget page) =>
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);
}

extension ExFutureDialog on BuildContext {
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
