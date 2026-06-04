import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_retaurant_form.dart';

class RestaurantNameField extends StatelessWidget {
  const RestaurantNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.splashTitleColor,
            ),
            children: [
              TextSpan(text: AppStrings.restaurantNameLabel),
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.secondaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AddRetaurantForm(),
      ],
    );
  }
}
