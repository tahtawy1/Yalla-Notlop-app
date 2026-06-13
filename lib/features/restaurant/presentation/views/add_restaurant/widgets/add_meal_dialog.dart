import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/header_text.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meal_field.dart';

class AddMealDialog extends StatefulWidget {
  const AddMealDialog({
    super.key,
    required this.mealNameController,
    required this.mealPriceController,
    required this.onSaveMeal,
  });

  final TextEditingController mealNameController;
  final TextEditingController mealPriceController;
  final Function onSaveMeal;

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText(title: AppStrings.mealNameLabel),
              const SizedBox(height: 8),
              MealField(
                hintText: AppStrings.mealNameHint,
                controller: widget.mealNameController,
              ),
              const SizedBox(height: 8),
              HeaderText(title: AppStrings.mealPriceLabel),
              const SizedBox(height: 8),
              MealField(
                hintText: AppStrings.mealPriceHint,
                controller: widget.mealPriceController,
                isPrice: true,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ActionButton(
                    title: AppStrings.saveButton,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSaveMeal();
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 20),
                  ActionButton(
                    title: AppStrings.cancelButton,
                    onTap: () {
                      formKey.currentState!.reset();
                      widget.mealNameController.clear();
                      widget.mealPriceController.clear();
                      Navigator.pop(context);
                    },
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
