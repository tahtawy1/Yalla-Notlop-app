import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

abstract class MealRepo {
  //* Meals ========================
  Future<Either<AppFailure, void>> addMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  });
  Future<Either<AppFailure, void>> updateMeal({
    required RestaurantModel restaurant,
    required MealModel oldMeal,
    required MealModel newMeal,
  });
  Future<Either<AppFailure, void>> deleteMeal({
    required RestaurantModel restaurant,
    required MealModel meal,
  });

  Future<Either<AppFailure, List<MealModel>>> getMeals({
    required RestaurantModel restaurant,
  });
}
