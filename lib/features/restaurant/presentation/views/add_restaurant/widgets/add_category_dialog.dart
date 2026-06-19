import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/shared/widgets/mini_field.dart';

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
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.splashTitleColor,
                    fontFamily: 'Cairo',
                  ),
                  children: [
                    TextSpan(text: S.of(context).categoryNameLabel),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              MiniField(
                hintText: S.of(context).categoryNameHint,
                controller: widget.categoryNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).enterNameValidation;
                  }
                  if (widget.existingCategories.contains(value.trim())) {
                    return S.of(context).categoryAlreadyExists;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ActionButton(
                    title: S.of(context).save,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSaveCategory();
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 20),
                  ActionButton(
                    title: S.of(context).cancel,
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
