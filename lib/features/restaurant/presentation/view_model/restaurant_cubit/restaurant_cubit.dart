import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit(this.repo) : super(const RestaurantInitial());

  final RestaurantRepo repo;

  List<MealModel> meals = [];
  List<CategoryModel> categories = [];

  CategoryModel? selectedCategory;
  File? image;

  //* ================== MEALS ==================

  void addMeal(MealModel meal) {
    meals = List.from(meals)..add(meal);
    emit(MealsUpdated());
  }

  void removeMeal(MealModel meal) {
    meals = List.from(meals)..remove(meal);
    emit(MealsUpdated());
  }

  //* ================== CATEGORY ==================

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    emit(CategoryUpdated());
  }

  //* ================== IMAGE ==================

  Future<void> pickImage() async {
    emit(PickRestaurantImageLoading());
    final res = await repo.pickImage();

    res.fold(
      (failure) => emit(PickRestaurantFailure(errMessage: failure.errMessage)),
      (file) {
        image = file;
        emit(PickRestaurantImageSuccess(image: file!));
      },
    );
  }

  //* ================== ADD RESTAURANT ==================

  Future<void> addRestaurant({required String name}) async {
    emit(AddRestaurantLoading());

    final res = await repo.addRestaurant(
      restaurant: _buildRestaurant(name: name),
    );

    res.fold(
      (failure) => emit(AddRestaurantFailure(errMessage: failure.errMessage)),
      (_) {
        emit(AddRestaurantSuccess());
        _reset();
      },
    );
  }

  //* ================== BUILD MODEL ==================

  RestaurantModel _buildRestaurant({required String name}) {
    return RestaurantModel(
      name: name,
      imagePath: image?.path,
      meals: List.from(meals),
      category: selectedCategory,
    );
  }

  //* ================== RESET ==================

  void _reset() {
    image = null;
    meals = [];
    selectedCategory = null;
    categories = [];
  }
}
