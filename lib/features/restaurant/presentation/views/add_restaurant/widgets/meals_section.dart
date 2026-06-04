import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meal_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meals_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meal_card.dart';

class MealsSection extends StatelessWidget {
  const MealsSection({
    super.key,
    required this.meals,
    required this.mealNameController,
    required this.mealPriceController,
    required this.onSaveMeal,
    required this.onDelete,
  });
  final List<MealModel> meals;

  final TextEditingController mealNameController;
  final TextEditingController mealPriceController;
  final Function(MealModel) onSaveMeal;
  final Function(MealModel) onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "الوجبات",
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
              AddMealsButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddMealDialog(
                      mealNameController: mealNameController,
                      mealPriceController: mealPriceController,
                      onSaveMeal: () {
                        onSaveMeal(
                          MealModel(
                            name: mealNameController.text,
                            price: mealPriceController.text,
                          ),
                        );
                      },
                    ),
                  );
                },
                isMealsEmpty: meals.isEmpty,
              ),
              ...meals.map(
                (meal) => MealCard(meal: meal, onDelete: () => onDelete(meal)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
