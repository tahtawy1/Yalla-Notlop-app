import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';

part 'manage_restaurant_state.dart';

class ManageRestaurantCubit extends Cubit<ManageRestaurantState> {
  ManageRestaurantCubit(this.restaurantRepo, this.categoryRepo, this.mealRepo)
    : super(ManageRestaurantInitial());

  final RestaurantRepo restaurantRepo;
  final CategoryRepo categoryRepo;
  final MealRepo mealRepo;

  late RestaurantModel originalRestaurant;

  List<MealModel> meals = [];
  List<CategoryModel> categories = [];

  CategoryModel? selectedCategory;
  File? image;
  String? imagePath;
  String? name;

  void initDraft(RestaurantModel restaurant) {
    originalRestaurant = restaurant;
    name = restaurant.name;
    selectedCategory = restaurant.category;
    imagePath = restaurant.imagePath;
    image = null;
    meals = restaurant.meals?.map((m) => m.copyWith()).toList() ?? [];
  }

  void discardChanges() {
    initDraft(originalRestaurant);
  }

  Future<void> saveUpdatedRestaurant() async {
    emit(SaveUpdatedRestaurantLoading());
    final newRestaurant = originalRestaurant.copyWith(
      name: name,
      category: selectedCategory,
      imagePath: image?.path ?? imagePath,
      meals: meals,
    );
    final result = await restaurantRepo.updateRestaurant(
      restaurant: newRestaurant,
    );

    result.fold(
      (failure) {
        emit(SaveUpdatedRestaurantFailure(errMessage: failure.errMessage));
      },
      (r) {
        emit(SaveUpdatedRestaurantSuccess(message: S.current.restaurantUpdatedSuccess));
      },
    );
  }

  void changeRestaurantName(String newName) {
    name = newName;
    emit(RestaurantNameUpdated(name: newName));
  }

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

  Future<void> addCategory(CategoryModel category) async {
    final normalized = category.name.trim().toLowerCase();
    final isDuplicate = categories.any(
      (c) => c.name.trim().toLowerCase() == normalized,
    );
    if (isDuplicate) {
      emit(AddCategoryFailure(errMessage: S.current.categoryAlreadyExists));
      return;
    }
    final newCategory = CategoryModel(name: category.name.trim());
    final result = await categoryRepo.addCategory(category: newCategory);
    result.fold(
      (failure) => emit(AddCategoryFailure(errMessage: failure.errMessage)),
      (_) => emit(AddCategorySuccess()),
    );
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    emit(CategoryUpdated());
  }

  Future<void> deleteCategory(CategoryModel category) async {
    emit(DeleteCategoryLoading());
    final restaurantsResult = await restaurantRepo.getRestaurants();
    bool isLinked = false;
    restaurantsResult.fold((l) {}, (restaurants) {
      isLinked = restaurants.any((r) => r.category?.id == category.id);
    });

    if (isLinked) {
      emit(
        DeleteCategoryFailure(
          errMessage: S.current.cannotDeleteCategoryWithRestaurants,
        ),
      );
      return;
    }

    final result = await categoryRepo.deleteCategory(category: category);
    result.fold(
      (failure) => emit(DeleteCategoryFailure(errMessage: failure.errMessage)),
      (_) {
        emit(DeleteCategorySuccess());
        getCategories();
      },
    );
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final result = await categoryRepo.getCategories();
    result.fold(
      (failure) {},
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }

  //* ================== MEALS ==================

  void addMeal(MealModel meal) {
    meals = List.from(meals)..add(meal);
    emit(MealsUpdated());
  }

  void updateMeal(MealModel oldMeal, MealModel newMeal) {
    final index = meals.indexWhere((meal) => meal.id == oldMeal.id);
    if (index != -1) {
      meals[index] = newMeal;
    }
    emit(MealsUpdated());
  }

  void removeMeal(MealModel meal) {
    meals = List.from(meals)..remove(meal);
    emit(MealsUpdated());
  }

  Future<void> deleteRestaurant(RestaurantModel restaurant) async {
    emit(DeleteRestaurantLoading());
    final result = await restaurantRepo.deleteRestaurant(
      restaurant: restaurant,
    );

    result.fold(
      (failure) =>
          emit(DeleteRestaurantFailure(errMessage: failure.errMessage)),
      (r) {
        _reset();
        emit(DeleteRestaurantSuccess(message: S.current.restaurantDeletedSuccess));
      },
    );
  }
  //* ================== RESET ==================

  void _reset() {
    image = null;
    meals = [];
    selectedCategory = null;
    categories = [];
    name = null;
  }
}
