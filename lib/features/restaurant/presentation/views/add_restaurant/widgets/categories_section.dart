import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_category_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_category_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/category_card.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelect,
    required this.onAdd,
    required this.onDelete,
    this.showError = false,
    required this.categoryNameController,
  });
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onSelect;
  final Function(String) onAdd;
  final Function(CategoryModel) onDelete;
  final bool showError;
  final TextEditingController categoryNameController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "الأقسام",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...categories.map(
                (category) => CategoryCard(
                  category: category,
                  isSelected: selectedCategory?.name == category.name,
                  onTap: () => onSelect(category),
                  onDelete: () => onDelete(category),
                ),
              ),
              AddCategoryButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddCategoryDialog(
                      categoryNameController: categoryNameController,
                      existingCategories: categories
                          .map((e) => e.name)
                          .toList(),
                      onSaveCategory: () {
                        onAdd(categoryNameController.text);
                      },
                    ),
                  );
                },
                isCategoriesEmpty: categories.isEmpty,
              ),
            ],
          ),
          if (showError && selectedCategory == null)
            const Padding(
              padding: EdgeInsets.only(top: 8.0, right: 20),
              child: Text(
                'الرجاء اختيار قسم',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
