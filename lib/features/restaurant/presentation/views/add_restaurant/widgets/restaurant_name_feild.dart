import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class RestaurantNameFeild extends StatelessWidget {
  const RestaurantNameFeild({
    super.key,
    required this.nameController,
    required this.autovalidateMode,
  });

  final TextEditingController nameController;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).restaurantNameValidation;
        }
        return null;
      },
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 14, color: AppColors.splashTitleColor),
      decoration: InputDecoration(
        hintText: S.of(context).restaurantNameExample,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.restaurantFieldHint,
        ),
        prefixIcon: const Icon(
          Icons.restaurant_menu_rounded,
          color: AppColors.restaurantFieldHint,
          size: 20,
        ),
        filled: true,
        fillColor: AppColors.restaurantBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.restaurantFieldBorder,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
