import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.linkedCount,
    required this.onEdit,
    required this.onDelete,
  });

  final CategoryModel category;
  final int linkedCount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.restaurantFieldBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.restaurantIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.category_rounded,
                color: AppColors.primaryColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.splashTitleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.restaurant_rounded,
                        size: 13,
                        color: AppColors.restaurantTextMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${context.l10n.linkedRestaurants}$linkedCount',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: AppColors.restaurantTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_rounded, size: 20),
              color: AppColors.primaryColor,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.restaurantIconBg,
                minimumSize: const Size(36, 36),
              ),
            ),
            const SizedBox(width: 6),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_rounded, size: 20),
              color: AppColors.dangerColor,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.dangerBackground,
                minimumSize: const Size(36, 36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
