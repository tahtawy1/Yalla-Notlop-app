import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.autovalidateMode,
    required this.validator,
    this.prefixIcon,
    required this.hintText,
    this.radius = 12,
    this.fillColor = AppColors.restaurantBackground,
    this.enabledBorderColor = AppColors.restaurantFieldBorder,
    this.focusedBorderColor = AppColors.secondaryColor,
    this.hintColor = AppColors.restaurantFieldHint,
    this.iconColor = AppColors.restaurantFieldHint,
  });

  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final String hintText;
  final double radius;
  final Color hintColor;
  final Color iconColor;
  final Color fillColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autovalidateMode,
      validator: validator,
      style: TextStyle(fontSize: 14, color: AppColors.splashTitleColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13, color: hintColor),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: iconColor, size: 20)
            : null,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: enabledBorderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
