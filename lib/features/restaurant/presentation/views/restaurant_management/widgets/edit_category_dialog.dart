import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/action_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/categories_section.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({
    super.key,
    required this.initialCategory,
    required this.onSaveCategory,
  });

  final CategoryModel? initialCategory;
  final Function(CategoryModel?) onSaveCategory;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  CategoryModel? selectedCategory;
  final TextEditingController categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    context.read<ManageRestaurantCubit>().getCategories();
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageRestaurantCubit, ManageRestaurantState>(
      listener: (context, state) {
        if (state is DeleteCategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is DeleteCategorySuccess) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).categoryDeletedSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<ManageRestaurantCubit, ManageRestaurantState>(
                  builder: (context, state) {
                    final cubit = context.read<ManageRestaurantCubit>();
                    return CategoriesSection(
                      categories: cubit.categories,
                      selectedCategory: selectedCategory,
                      categoryNameController: categoryNameController,
                      onSelect: (cat) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                      onAdd: (name) {
                        final newCat = CategoryModel(name: name);
                        cubit.addCategory(newCat);
                      },
                      onDelete: (cat) {
                        cubit.deleteCategory(cat);
                        if (selectedCategory?.id == cat.id) {
                          setState(() {
                            selectedCategory = null;
                          });
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ActionButton(
                      title: S.of(context).save,
                      onTap: () {
                        widget.onSaveCategory(selectedCategory);
                        Navigator.pop(context);
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
      ),
    );
  }
}
