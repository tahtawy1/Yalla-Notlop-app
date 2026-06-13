import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    super.key,
    required this.onTap,
    required this.isCategoriesEmpty,
  });

  final VoidCallback onTap;
  final bool isCategoriesEmpty;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        // duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.restaurantBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.restaurantFieldBorder,
            width: 1.5,
          ),
        ),
        child: isCategoriesEmpty
            ? Row(
                mainAxisSize: isCategoriesEmpty
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.primaryColor, size: 20),
                  SizedBox(width: 8),
                  Text(
                    AppStrings.addCategoryButton,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              )
            : const Icon(Icons.add, color: AppColors.primaryColor, size: 20),
      ),
    );
  }
}
