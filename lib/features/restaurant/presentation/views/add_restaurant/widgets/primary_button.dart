import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    this.postfixIcon,
    this.isLoading = false,
    required this.color,
    this.prefixIcon,
    this.radius = 16,
    this.fontSize = 16,
    this.iconSize = 20,
    this.textColor = AppColors.surface,
  });

  final VoidCallback onTap;
  final String title;
  final IconData? postfixIcon;
  final IconData? prefixIcon;
  final Color color;
  final Color textColor;
  final bool isLoading;
  final double radius;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.surface))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  postfixIcon != null
                      ? Icon(postfixIcon, color: textColor, size: 20)
                      : const SizedBox(),
                  postfixIcon != null ? SizedBox(width: 8) : const SizedBox(),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  prefixIcon != null ? SizedBox(width: 8) : const SizedBox(),

                  prefixIcon != null
                      ? Icon(prefixIcon, color: textColor, size: iconSize)
                      : const SizedBox(),
                ],
              ),
            ),
    );
  }
}
