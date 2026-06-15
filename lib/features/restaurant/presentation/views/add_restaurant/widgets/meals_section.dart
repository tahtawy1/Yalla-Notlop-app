import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meal_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meals_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meal_card.dart';

class MealsSection extends StatefulWidget {
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
  State<MealsSection> createState() => _MealsSectionState();
}

class _MealsSectionState extends State<MealsSection> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).meals,
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
                      mealNameController: widget.mealNameController,
                      mealPriceController: widget.mealPriceController,
                      onSaveMeal: () {
                        widget.onSaveMeal(
                          MealModel(
                            name: widget.mealNameController.text,
                            price: widget.mealPriceController.text,
                          ),
                        );
                      },
                    ),
                  );
                },
                isMealsEmpty: widget.meals.isEmpty,
              ),
              ...widget.meals.map(
                (meal) =>
                    MealCard(meal: meal, onDelete: () => widget.onDelete(meal)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
