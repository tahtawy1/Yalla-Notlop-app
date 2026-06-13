import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, required this.onDelete});
  final MealModel meal;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.restaurantFieldBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Text(
                meal.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.splashTitleColor,
                ),
              ),
              SizedBox(width: 4),
              Text(
                meal.price,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.splashTitleColor,
                ),
              ),
              SizedBox(width: 4),
              InkWell(
                onTap: onDelete,
                child: Icon(Icons.close, color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
