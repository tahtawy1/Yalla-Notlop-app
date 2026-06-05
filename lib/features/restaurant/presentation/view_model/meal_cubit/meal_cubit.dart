import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit(this.repo) : super(MealInitial());
  final MealRepo repo;
  Future<void> addMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    emit(AddMealLoading());
    final result = await repo.addMeal(restaurant: restaurant, meal: meal);
    result.fold(
      (failure) => emit(AddMealFailure(errMessage: failure.errMessage)),
      (r) => emit(AddMealSuccess()),
    );
  }

  Future<void> updateMeal({
    required RestaurantModel restaurant,
    required MealModel oldMeal,
    required MealModel newMeal,
  }) async {
    emit(UpdateMealLoading());
    final result = await repo.updateMeal(
      restaurant: restaurant,
      oldMeal: oldMeal,
      newMeal: newMeal,
    );
    result.fold(
      (failure) => emit(UpdateMealFailure(errMessage: failure.errMessage)),
      (r) => emit(UpdateMealSuccess()),
    );
  }

  Future<void> deleteMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    emit(DeleteMealLoading());
    final result = await repo.deleteMeal(restaurant: restaurant, meal: meal);
    result.fold(
      (failure) => emit(DeleteMealFailure(errMessage: failure.errMessage)),
      (r) => emit(DeleteMealSuccess()),
    );
  }

  Future<void> getMeals({required RestaurantModel restaurant}) async {
    emit(GetMealsLoading());
    final result = await repo.getMeals(restaurant: restaurant);
    result.fold(
      (failure) => emit(GetMealsFailure(errMessage: failure.errMessage)),
      (meals) => emit(GetMealsSuccess(meals: meals)),
    );
  }
}
