import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class FAButton extends StatelessWidget {
  const FAButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding = 0,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        padding: EdgeInsetsDirectional.only(start: padding),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 4),
            Icon(icon, color: Colors.white, size: 28),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
