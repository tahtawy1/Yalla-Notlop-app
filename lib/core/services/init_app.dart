import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MealModelAdapter());
  Hive.registerAdapter(RestaurantModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(MemberModelAdapter());

  await Hive.openBox<RestaurantModel>("restaurantsBox");
  await Hive.openBox<CategoryModel>("categoriesBox");
  await Hive.openBox<MemberModel>("membersBox");
  await setupLocators();
}
