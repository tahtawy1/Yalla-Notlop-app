import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).appName,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryColor,
      ),
    );
  }
}
