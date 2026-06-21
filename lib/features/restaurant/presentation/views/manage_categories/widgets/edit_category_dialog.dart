import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/shared/widgets/mini_field.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({
    super.key,
    required this.category,
    required this.onSave,
  });

  final CategoryModel category;
  final void Function(String newName) onSave;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    fontFamily: 'Cairo',
                  ),
                  children: [
                    TextSpan(text: context.l10n.editCategory),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              MiniField(
                hintText: widget.category.name,
                controller: _controller,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l10n.enterNameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ActionButton(
                    title: context.l10n.save,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave(_controller.text.trim());
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  ActionButton(
                    title: context.l10n.cancel,
                    onTap: () => Navigator.pop(context),
                    color: AppColors.secondary,
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
