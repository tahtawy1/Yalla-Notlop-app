import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class MiniField extends StatelessWidget {
  const MiniField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPrice = false,
    this.validator,
    this.wantValidation = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPrice;
  final String? Function(String?)? validator;
  final bool wantValidation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isPrice ? TextInputType.number : TextInputType.text,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return isPrice
                  ? S.of(context).mealPriceRequired
                  : S.of(context).enterNameValidation;
            }
            if (isPrice && double.tryParse(value.trim()) == null) {
              return S.of(context).invalidPriceValidation;
            }
            return null;
          },
      style: const TextStyle(fontSize: 14, color: AppColors.splashTitleColor),
      decoration: InputDecoration(
        errorStyle: wantValidation ? null : TextStyle(fontSize: 0),
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
