import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';

class CategoryPickerDialog extends StatefulWidget {
  const CategoryPickerDialog({
    super.key,
    required this.categories,
    required this.excludeCategory,
    required this.onSelected,
  });

  final List<CategoryModel> categories;
  final CategoryModel excludeCategory;
  final void Function(CategoryModel selected) onSelected;

  @override
  State<CategoryPickerDialog> createState() => _CategoryPickerDialogState();
}

class _CategoryPickerDialogState extends State<CategoryPickerDialog> {
  CategoryModel? _selected;

  @override
  Widget build(BuildContext context) {
    final available = widget.categories
        .where((c) => c.id != widget.excludeCategory.id)
        .toList();

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        context.l10n.selectTargetCategory,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w800,
          fontSize: 15,
          color: AppColors.textPrimary,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: available.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  context.l10n.noCategoriesAvailable,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: AppColors.textMuted,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: available.length,
                itemBuilder: (context, index) {
                  final cat = available[index];
                  final isSelected = _selected?.id == cat.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.chipSelected
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.secondary
                              : AppColors.border,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            color: isSelected
                                ? AppColors.secondary
                                : AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cat.name,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.cancel,
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: AppColors.textMuted,
            ),
          ),
        ),
        if (available.isNotEmpty)
          ElevatedButton(
            onPressed: _selected == null
                ? null
                : () {
                    widget.onSelected(_selected!);
                    Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              context.l10n.save,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w800,
                color: AppColors.surface,
              ),
            ),
          ),
      ],
    );
  }
}
