import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppColors.splashTitleColor,
          fontFamily: 'Cairo',
        ),
        children: [
          TextSpan(text: title),
          TextSpan(
            text: ' *',
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }
}
