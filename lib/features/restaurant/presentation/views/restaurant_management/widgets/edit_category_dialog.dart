import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
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
  late List<CategoryModel> categories;
  CategoryModel? selectedCategory;
  final TextEditingController categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final box = Hive.box<CategoryModel>("categoriesBox");
    categories = box.values.toList();

    // Find initial category by name if it exists
    if (widget.initialCategory != null) {
      try {
        selectedCategory = categories.firstWhere(
          (cat) => cat.name == widget.initialCategory!.name,
        );
      } catch (e) {
        selectedCategory = null;
      }
    }
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CategoriesSection(
                categories: categories,
                selectedCategory: selectedCategory,
                categoryNameController: categoryNameController,
                onSelect: (cat) {
                  setState(() {
                    selectedCategory = cat;
                  });
                },
                onAdd: (name) async {
                  final newCat = CategoryModel(name: name);
                  await Hive.box<CategoryModel>("categoriesBox").add(newCat);
                  setState(() {
                    categories.add(newCat);
                    selectedCategory = newCat;
                  });
                },
                onDelete: (cat) async {
                  await cat.delete();
                  setState(() {
                    categories.remove(cat);
                    if (selectedCategory?.name == cat.name) {
                      selectedCategory = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ActionButton(
                    title: 'حفظ',
                    onTap: () {
                      widget.onSaveCategory(selectedCategory);
                      Navigator.pop(context);
                    },
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 20),
                  ActionButton(
                    title: 'إلغاء',
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
