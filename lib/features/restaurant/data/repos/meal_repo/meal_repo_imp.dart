import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';

class MealRepoImp implements MealRepo {
  //* Meal ========================

  @override
  Future<Either<AppFailure, void>> addMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    try {
      await HiveService().addMeal(restaurant, meal);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في إضافة الوجبة'));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateMeal({
    required RestaurantModel restaurant,
    required MealModel oldMeal,
    required MealModel newMeal,
  }) async {
    try {
      await HiveService().updateMeal(restaurant, oldMeal, newMeal);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في تحديث الوجبة'));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  }) async {
    try {
      await HiveService().deleteMeal(restaurant, meal);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في حذف الوجبة'));
    }
  }

  @override
  Future<Either<AppFailure, List<MealModel>>> getMeals({
    required RestaurantModel restaurant,
  }) async {
    try {
      return right(HiveService().getMeals(restaurant));
    } catch (e) {
      return Left(AppFailure('حدث خطأ في جلب الوجبات'));
    }
  }
}
