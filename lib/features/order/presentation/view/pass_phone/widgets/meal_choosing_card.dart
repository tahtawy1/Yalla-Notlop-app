import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class MealChoosingCard extends StatelessWidget {
  const MealChoosingCard({
    super.key,
    required this.meal,
    required this.onMealAdded,
    required this.onMealRemoved,
    required this.mealCounter,
  });
  final MealModel meal;
  final VoidCallback onMealAdded;
  final VoidCallback onMealRemoved;
  final int mealCounter;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(height: 4),
                Text(
                  '${meal.price} ${S.of(context).mealPriceSuffix}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onMealAdded,
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '$mealCounter',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: 6),
              GestureDetector(
                onTap: onMealRemoved,
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
