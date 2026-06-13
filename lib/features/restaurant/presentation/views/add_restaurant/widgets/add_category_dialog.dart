import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meal_field.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({
    super.key,
    required this.categoryNameController,
    required this.onSaveCategory,
    required this.existingCategories,
  });

  final TextEditingController categoryNameController;
  final Function onSaveCategory;
  final List<String> existingCategories;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

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
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.splashTitleColor,
                    fontFamily: 'Cairo',
                  ),
                  children: [
                    TextSpan(text: AppStrings.categoryNameLabel),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              MealField(
                hintText: AppStrings.categoryNameHint,
                controller: widget.categoryNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterNameValidation;
                  }
                  if (widget.existingCategories.contains(value.trim())) {
                    return AppStrings.categoryAlreadyExists;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ActionButton(
                    title: AppStrings.saveButton,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSaveCategory();
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 20),
                  ActionButton(
                    title: AppStrings.cancelButton,
                    onTap: () {
                      formKey.currentState!.reset();
                      widget.categoryNameController.clear();
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
