import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/shared/widgets/app_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onRestaurantAdded});
  final VoidCallback onRestaurantAdded;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 48),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary, size: 28),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              const Expanded(child: Center(child: AppLogo())),
              const SizedBox(width: 48),
            ],
          ),
          SizedBox(height: 16),
          Text(
            context.l10n.homeTitle,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            context.l10n.homeSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
