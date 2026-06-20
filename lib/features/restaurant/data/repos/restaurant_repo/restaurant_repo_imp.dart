import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/restaurant_hive_service.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/pick_image.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class RestaurantRepoImp implements RestaurantRepo {
  final RestaurantHiveService hiveService;

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
      return Left(AppFailure(S.current.addRestaurantError));
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
      return Left(AppFailure(S.current.updateRestaurantError));
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
      return Left(AppFailure(S.current.deleteRestaurantError));
    }
  }

  @override
  Future<Either<AppFailure, List<RestaurantModel>>> getRestaurants() async {
    try {
      return right(hiveService.getRestaurants());
    } catch (e) {
      return Left(AppFailure(S.current.fetchRestaurantsError));
    }
  }

  @override
  Future<Either<AppFailure, File?>> pickImage() async {
    try {
      final image = await pickkImage();
      if (image == null) {
        return Left(AppFailure(S.current.noImageSelected));
      }
      return right(image);
    } catch (e) {
      return Left(AppFailure(S.current.pickImageError));
    }
  }

  //* Category-related operations ========
  @override
  Future<Either<AppFailure, Map<String, int>>>
  getRestaurantCountPerCategory() async {
    try {
      final restaurants = hiveService.getRestaurants();
      final Map<String, int> countMap = {};
      for (final r in restaurants) {
        final catId = r.category?.id;
        if (catId != null) {
          countMap[catId] = (countMap[catId] ?? 0) + 1;
        }
      }
      return right(countMap);
    } catch (e) {
      return Left(AppFailure(S.current.genericError));
    }
  }

  @override
  Future<Either<AppFailure, void>> changeRelatedRestaurantsCategory({
    required CategoryModel oldCategory,
    required CategoryModel newCategory,
  }) async {
    try {
      final restaurants = hiveService.getRestaurants();
      for (final r in restaurants) {
        if (r.category?.id == oldCategory.id) {
          await hiveService.updateRestaurant(r.copyWith(category: newCategory));
        }
      }
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.genericError));
    }
  }

  @override
  Future<Either<AppFailure, void>> forceDeleteCategoryWithRestaurants({
    required CategoryModel category,
  }) async {
    try {
      final restaurants = hiveService.getRestaurants();
      for (final r in restaurants) {
        if (r.category?.id == category.id) {
          await hiveService.deleteRestaurant(r);
        }
      }
      await hiveService.deleteCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.genericError));
    }
  }
}
