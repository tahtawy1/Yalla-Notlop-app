import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class RestaurantHeaderSection extends StatelessWidget {
  const RestaurantHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.restaurantIconBg,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.storefront_rounded,
            color: AppColors.primaryColor,
            size: 38,
          ),
        ),
        SizedBox(height: 16),
        Text(
          S.of(context).addRestaurantTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.splashTitleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          S.of(context).addRestaurantSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.restaurantTextMuted,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
