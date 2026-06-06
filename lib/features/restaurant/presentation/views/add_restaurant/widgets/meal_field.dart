import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class MealField extends StatelessWidget {
  const MealField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPrice = false,
    this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPrice;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isPrice ? TextInputType.number : TextInputType.text,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال ${isPrice ? 'السعر' : 'الاسم'}';
            }
            if (isPrice && double.tryParse(value.trim()) == null) {
              return 'الرجاء إدخال سعر صحيح';
            }
            return null;
          },
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 14, color: AppColors.splashTitleColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.restaurantFieldHint,
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
