import 'dart:io';

import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

abstract class RestaurantRepo {
  Future<void> addRestaurant({required RestaurantModel restaurant});
  List<RestaurantModel> getRestaurants();
  Future<void> addCategory({required CategoryModel category});
  Future<void> deleteCategory({required CategoryModel category});
  List<CategoryModel> getCategories();
  Future<File?> pickImage();
}
