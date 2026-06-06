import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class HiveService {
  final Box<RestaurantModel> _box = Hive.box<RestaurantModel>("restaurantsBox");
  final Box<CategoryModel> _categoryBox = Hive.box<CategoryModel>(
    "categoriesBox",
  );

  List<RestaurantModel> getRestaurants() {
    return _box.values.toList();
  }

  Future<void> addRestaurant(RestaurantModel restaurant) async {
    await _box.put(restaurant.id, restaurant);
  }

  Future<void> updateRestaurant(RestaurantModel restaurant) async {
    await _box.put(restaurant.id, restaurant);
  }

  Future<void> deleteRestaurant(RestaurantModel restaurant) async {
    await _box.delete(restaurant.id);
  }

  List<CategoryModel> getCategories() {
    return _categoryBox.values.toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _categoryBox.put(category.id, category);
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _categoryBox.put(category.id, category);
  }

  Future<void> deleteCategory(CategoryModel category) async {
    await _categoryBox.delete(category.id);
  }

  Future<void> addMeal(RestaurantModel restaurant, MealModel meal) async {
    final updatedMeals = List<MealModel>.from(restaurant.meals ?? [])
      ..add(meal);
    final updated = restaurant.copyWith(meals: updatedMeals);
    await _box.put(updated.id, updated);
  }

  Future<void> updateMeal(
    RestaurantModel restaurant,
    MealModel oldMeal,
    MealModel newMeal,
  ) async {
    final updatedMeals = List<MealModel>.from(restaurant.meals ?? [])
        .map(
          (m) =>
              m.name == oldMeal.name && m.price == oldMeal.price ? newMeal : m,
        )
        .toList();
    final updated = restaurant.copyWith(meals: updatedMeals);
    await _box.put(updated.id, updated);
  }

  Future<void> deleteMeal(RestaurantModel restaurant, MealModel meal) async {
    final updatedMeals = List<MealModel>.from(restaurant.meals ?? [])
      ..removeWhere((m) => m.name == meal.name && m.price == meal.price);
    final updated = restaurant.copyWith(meals: updatedMeals);
    await _box.put(updated.id, updated);
  }

  List<MealModel> getMeals(RestaurantModel restaurant) {
    return restaurant.meals ?? [];
  }
}
