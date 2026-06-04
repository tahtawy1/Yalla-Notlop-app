import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MealModelAdapter());
  Hive.registerAdapter(RestaurantModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<RestaurantModel>("restaurantsBox");
  await Hive.openBox<CategoryModel>("categoriesBox");
}
