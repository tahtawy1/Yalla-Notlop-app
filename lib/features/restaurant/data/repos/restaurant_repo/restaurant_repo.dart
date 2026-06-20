import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

abstract class RestaurantRepo {
  //* Restaurants ========================
  Future<Either<AppFailure, void>> addRestaurant({
    required RestaurantModel restaurant,
  });
  Future<Either<AppFailure, void>> updateRestaurant({
    required RestaurantModel restaurant,
  });
  Future<Either<AppFailure, void>> deleteRestaurant({
    required RestaurantModel restaurant,
  });
  Future<Either<AppFailure, List<RestaurantModel>>> getRestaurants();

  Future<Either<AppFailure, File?>> pickImage();

  //* Category-related operations ========
  Future<Either<AppFailure, Map<String, int>>> getRestaurantCountPerCategory();
  Future<Either<AppFailure, void>> changeRelatedRestaurantsCategory({
    required CategoryModel oldCategory,
    required CategoryModel newCategory,
  });
  Future<Either<AppFailure, void>> forceDeleteCategoryWithRestaurants({
    required CategoryModel category,
  });
}
