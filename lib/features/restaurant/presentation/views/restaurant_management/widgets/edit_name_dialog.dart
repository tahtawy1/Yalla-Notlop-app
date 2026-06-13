import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meal_field.dart';

class EditNameDialog extends StatefulWidget {
  const EditNameDialog({
    super.key,
    required this.initialName,
    required this.onSaveName,
  });

  final String initialName;
  final Function(String) onSaveName;

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late TextEditingController nameController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    nameController.dispose();
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
            mainAxisSize: MainAxisSize.min,
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
                    TextSpan(text: AppStrings.editRestaurantNameLabel),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              MealField(
                hintText: AppStrings.restaurantNameInputHint,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterNameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ActionButton(
                    title: AppStrings.saveButton,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSaveName(nameController.text.trim());
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 20),
                  ActionButton(
                    title: AppStrings.cancelButton,
                    onTap: () => Navigator.pop(context),
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
