import 'package:flutter/material.dart';

class AppSnackBar {
  static void showSnackBar(
    BuildContext context,
    String message,
    SnackBarType type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: type == SnackBarType.success
            ? Colors.green
            : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

enum SnackBarType { success, error }
