import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

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
            ? AppColors.success
            : AppColors.danger,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

enum SnackBarType { success, error }
