import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class AddMealsButton extends StatelessWidget {
  const AddMealsButton({
    super.key,
    required this.onTap,
    required this.isMealsEmpty,
  });

  final VoidCallback onTap;
  final bool isMealsEmpty;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.restaurantBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.restaurantFieldBorder,
            width: 1.5,
          ),
        ),
        child: isMealsEmpty
            ? Row(
                mainAxisSize: isMealsEmpty
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.secondaryColor,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    context.l10n.addMeals,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              )
            : const Icon(
                Icons.add,
                key: ValueKey('icon'),
                color: AppColors.secondaryColor,
                size: 20,
              ),
      ),
    );
  }
}
