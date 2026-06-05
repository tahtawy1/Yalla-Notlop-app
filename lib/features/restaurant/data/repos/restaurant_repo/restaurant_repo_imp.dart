import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/pick_image.dart';

class RestaurantRepoImp implements RestaurantRepo {
  //* Restraunts ========================
  @override
  Future<Either<AppFailure, void>> addRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await HiveService().addRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في إضافة المطعم'));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await HiveService().updateRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في تحديث المطعم'));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteRestaurant({
    required RestaurantModel restaurant,
  }) async {
    try {
      await HiveService().deleteRestaurant(restaurant);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في حذف المطعم'));
    }
  }

  @override
  Future<Either<AppFailure, List<RestaurantModel>>> getRestaurants() async {
    try {
      return right(HiveService().getRestaurants());
    } catch (e) {
      return Left(AppFailure('حدث خطأ في جلب المطاعم'));
    }
  }

  @override
  Future<Either<AppFailure, File?>> pickImage() async {
    try {
      final image = await pickkImage();
      if (image == null) {
        return Left(AppFailure('لم يتم اختيار صورة'));
      }
      return right(image);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في اختيار الصورة'));
    }
  }
}
