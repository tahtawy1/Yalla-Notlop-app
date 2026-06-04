import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit(this.repo) : super(const RestaurantInitial()) {
    getCategories();
  }

  final RestaurantRepo repo;
  List<MealModel> meals = [];
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  File? image;

  void addMeal(MealModel meal) {
    meals.add(meal);
  }

  void removeMeal(MealModel meal) {
    meals.remove(meal);
  }

  void getCategories() {
    categories = repo.getCategories();
    emit(RestaurantInitial());
  }

  Future<void> addCategory(String name) async {
    final category = CategoryModel(name: name);
    await repo.addCategory(category: category);
    categories.add(category);
    selectedCategory = category;
    emit(RestaurantCategoryChanged());
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    emit(RestaurantCategoryChanged());
  }

  Future<void> removeCategory(CategoryModel category) async {
    await repo.deleteCategory(category: category);
    categories.remove(category);
    if (selectedCategory == category) {
      selectedCategory = null;
    }
    emit(RestaurantCategoryChanged());
  }

  void addRestaurant({required String name}) {
    try {
      emit(RestaurantAdding());
      repo.addRestaurant(
        restaurant: RestaurantModel(
          name: name,
          imagePath: image?.path,
          meals: meals,
          category: selectedCategory,
        ),
      );
      meals.clear();
      selectedCategory = null;
      emit(RestaurantAddedSuccess());
      final rests = repo.getRestaurants();
      for (var rest in rests) {
        log(rest.name);
      }
    } catch (e) {
      emit(RestaurantAddedFailure(errMessage: e.toString()));
    }
  }

  Future<void> pickImage() async {
    try {
      final file = await repo.pickImage();
      if (file != null) {
        image = file;
        emit(RestaurantImagePicked(image: file));
      }
    } catch (e) {
      emit(RestaurantImagePickedFailure(errMessage: e.toString()));
    }
  }
}
