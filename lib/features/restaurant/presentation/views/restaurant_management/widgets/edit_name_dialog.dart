import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
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
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.splashTitleColor,
                  ),
                  children: [
                    TextSpan(text: S.of(context).editRestaurantName),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              MealField(
                hintText: S.of(context).restaurantNameHint,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).enterNameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ActionButton(
                    title: S.of(context).save,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSaveName(nameController.text.trim());
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 20),
                  ActionButton(
                    title: S.of(context).cancel,
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
