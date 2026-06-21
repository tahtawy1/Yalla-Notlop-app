import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class DangerOutlinedButton extends StatelessWidget {
  const DangerOutlinedButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.dangerBackground,
              side: const BorderSide(color: AppColors.danger, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: AppColors.danger,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  context.l10n.deleteRestaurantPermanently,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.danger,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          context.l10n.deleteRestaurantWarning,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: AppColors.hint),
        ),
      ],
    );
  }
}
