import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/pick_image.dart';

class RestaurantRepoImp implements RestaurantRepo {
  final HiveService hiveService;

  RestaurantRepoImp({required this.hiveService});
  //* Restraunts ========================
  @override
  Future<Either<AppFailure, void>> addRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await hiveService.addRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure(AppStrings.addRestaurantError));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await hiveService.updateRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure(AppStrings.updateRestaurantError));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await hiveService.deleteRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure(AppStrings.deleteRestaurantError));
    }
  }

  @override
  Future<Either<AppFailure, List<RestaurantModel>>> getRestaurants() async {
    try {
      return right(hiveService.getRestaurants());
    } catch (e) {
      return Left(AppFailure(AppStrings.getRestaurantsError));
    }
  }

  @override
  Future<Either<AppFailure, File?>> pickImage() async {
    try {
      final image = await pickkImage();
      if (image == null) {
        return Left(AppFailure(AppStrings.noImageSelected));
      }
      return right(image);
    } catch (e) {
      return Left(AppFailure(AppStrings.pickImageError));
    }
  }
}
