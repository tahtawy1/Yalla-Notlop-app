import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.appName,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryColor,
      ),
    );
  }
}
