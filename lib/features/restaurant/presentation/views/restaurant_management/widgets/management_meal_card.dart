import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

class ManagementMealCard extends StatelessWidget {
  const ManagementMealCard({
    super.key,
    required this.meal,
    required this.onEdit,
    required this.onDelete,
  });

  final MealModel meal;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withAlpha(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Image.asset(AppImageAssets.mealIcon, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.splashTitleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${meal.price} ${AppStrings.mealPriceSuffix}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: onEdit,
                child: const Icon(
                  Icons.edit,
                  color: AppColors.restaurantTextMuted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
