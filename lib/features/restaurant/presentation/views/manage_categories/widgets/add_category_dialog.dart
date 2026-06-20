import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/shared/widgets/mini_field.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key, required this.onAdd});

  final void Function(String name) onAdd;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
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
                    color: AppColors.splashTitleColor,
                    fontFamily: 'Cairo',
                  ),
                  children: [
                    TextSpan(text: context.l10n.addCategory),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              MiniField(
                hintText: context.l10n.categories,
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
                    title: context.l10n.addCategory,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onAdd(_controller.text.trim());
                        Navigator.pop(context);
                      }
                    },
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  ActionButton(
                    title: context.l10n.cancel,
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
