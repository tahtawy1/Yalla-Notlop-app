import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_categories_cubit/manage_categories_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/widgets/category_picker_dialog.dart';

class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog({
    super.key,
    required this.category,
    required this.linkedCount,
    required this.allCategories,
  });

  final CategoryModel category;
  final int linkedCount;
  final List<CategoryModel> allCategories;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageCategoriesCubit>();

    if (linkedCount == 0) {
      return AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.danger,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.deleteCategoryConfirmationTitle,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          context.l10n.deleteCategoryEmptyConfirmationMsg,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            color: AppColors.textMuted,
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteCategoryIfEmpty(category);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              context.l10n.delete,
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

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(Icons.link_rounded, color: AppColors.secondary, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.l10n.deleteCategoryConfirmationTitle,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.deleteCategoryWithRestaurantsMsg,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          _OptionTile(
            icon: Icons.drive_file_move_rounded,
            color: AppColors.primary,
            bgColor: AppColors.iconBackground,
            label: context.l10n.moveRestaurantsToAnotherCategory,
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: CategoryPickerDialog(
                    categories: allCategories,
                    excludeCategory: category,
                    onSelected: (target) {
                      cubit.changeRelatedRestaurantsCategory(
                        oldCategory: category,
                        newCategory: target,
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _OptionTile(
            icon: Icons.delete_forever_rounded,
            color: AppColors.danger,
            bgColor: AppColors.dangerBackground,
            label: context.l10n.deleteAllRestaurantsWithCategory,
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: _ForceDeleteConfirmDialog(category: category),
                ),
              );
            },
          ),
        ],
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
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.7)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForceDeleteConfirmDialog extends StatelessWidget {
  const _ForceDeleteConfirmDialog({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(
            Icons.dangerous_rounded,
            color: AppColors.danger,
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.deleteAllRestaurantsWithCategory,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: AppColors.danger,
            ),
          ),
        ],
      ),
      content: Text(
        context.l10n.deleteCategoryWithRestaurantsWarning,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 13,
          color: AppColors.textMuted,
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
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            context
                .read<ManageCategoriesCubit>()
                .forceDeleteCategoryWithRestaurants(category);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.danger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            context.l10n.delete,
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
