import 'dart:developer';
import 'dart:io';

import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';

class RestaurantRepoImp implements RestaurantRepo {
  @override
  Future<void> addRestaurant({required RestaurantModel restaurant}) async {
    try {
      await HiveService().addRestaurant(restaurant);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  List<RestaurantModel> getRestaurants() {
    try {
      return HiveService().getRestaurants();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  List<CategoryModel> getCategories() {
    try {
      return HiveService().getCategories();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<void> addCategory({required CategoryModel category}) async {
    try {
      await HiveService().addCategory(category);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> deleteCategory({required CategoryModel category}) async {
    try {
      await HiveService().deleteCategory(category);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<File?> pickImage() async {
    try {
      return await pickImage();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
