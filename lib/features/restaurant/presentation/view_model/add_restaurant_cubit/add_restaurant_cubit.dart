import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';

part 'add_restaurant_state.dart';

class AddRestaurantCubit extends Cubit<AddRestaurantState> {
  AddRestaurantCubit(this.restaurantRepo, this.categoryRepo)
    : super(const AddRestaurantInitial());

  final RestaurantRepo restaurantRepo;
  final CategoryRepo categoryRepo;

  List<MealModel> meals = [];
  List<CategoryModel> categories = [];

  CategoryModel? selectedCategory;
  String? selectedImagePath;
  File? image;

  Future<void> addCategory({required String name}) async {
    final normalized = name.trim().toLowerCase();
    final isDuplicate = categories.any(
      (c) => c.name.trim().toLowerCase() == normalized,
    );
    if (isDuplicate) {
      emit(AddCategoryFailure(errMessage: AppStrings.categoryAlreadyExists));
      return;
    }
    final res = await categoryRepo.addCategory(
      category: _buildCategory(name.trim()),
    );
    res.fold(
      (failure) => emit(AddCategoryFailure(errMessage: failure.errMessage)),
      (r) => emit(AddCategorySuccess()),
    );
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final result = await categoryRepo.getCategories();
    result.fold(
      (failure) => emit(GetCategoriesFailure(errMessage: failure.errMessage)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }

  CategoryModel _buildCategory(String name) {
    return CategoryModel(name: name);
  }

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
    final res = await restaurantRepo.pickImage();

    res.fold(
      (failure) =>
          emit(PickRestaurantImageFailure(errMessage: failure.errMessage)),
      (file) {
        image = file;
        emit(PickRestaurantImageSuccess(image: file!));
      },
    );
  }

  void selectImagePath({required String imagePath}) {
    selectedImagePath = imagePath;
    emit(ImagePathUpdated());
  }

  //* ================== ADD RESTAURANT ==================

  Future<void> addRestaurant({required String name}) async {
    emit(AddRestaurantLoading());

    final res = await restaurantRepo.addRestaurant(
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
      imagePath: image?.path ?? selectedImagePath,
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
