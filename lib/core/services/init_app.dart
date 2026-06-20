import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/core/constants/hive_boxes.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MealModelAdapter());
  Hive.registerAdapter(RestaurantModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(MemberModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());

  await Hive.openBox<RestaurantModel>(HiveBoxes.restaurantsBox);
  await Hive.openBox<CategoryModel>(HiveBoxes.categoriesBox);
  await Hive.openBox<MemberModel>(HiveBoxes.membersBox);
  await Hive.openBox<OrderModel>(HiveBoxes.ordersBox);
  await Hive.openBox<OrderModel>(HiveBoxes.orderHistoryBox);
  await setupLocators();
}
