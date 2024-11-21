import 'package:flutter/material.dart';

class BasicSnackBar {
  // This function shows a snackbar
  static void showSnackbar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      behavior: SnackBarBehavior.floating,
    );

    // Remove any existing snackbar and show the new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
