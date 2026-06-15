import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';

class MealRepoImp implements MealRepo {
  final HiveService hiveService;

  MealRepoImp({required this.hiveService});
  //* Meal ========================

  @override
  Future<Either<AppFailure, void>> addMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    try {
      await hiveService.addMeal(restaurant, meal);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.addMealError));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateMeal({
    required RestaurantModel restaurant,
    required MealModel oldMeal,
    required MealModel newMeal,
  }) async {
    try {
      await hiveService.updateMeal(restaurant, oldMeal, newMeal);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.updateMealError));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    try {
      await hiveService.deleteMeal(restaurant, meal);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.deleteMealError));
    }
  }

  @override
  Future<Either<AppFailure, List<MealModel>>> getMeals({
    required RestaurantModel restaurant,
  }) async {
    try {
      return right(hiveService.getMeals(restaurant));
    } catch (e) {
      return Left(AppFailure(S.current.fetchMealsError));
    }
  }
}
