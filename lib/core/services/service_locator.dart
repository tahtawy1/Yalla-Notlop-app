import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocators() async {
  getIt.registerLazySingleton(
    () => Hive.box<RestaurantModel>("restaurantsBox"),
  );

  getIt.registerLazySingleton(() => Hive.box<CategoryModel>("categoriesBox"));

  getIt.registerLazySingleton(
    () => HiveService(restaurantsBox: getIt(), categoryBox: getIt()),
  );
  getIt.registerLazySingleton<RestaurantRepo>(
    () => RestaurantRepoImp(hiveService: getIt()),
  );
  getIt.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImp(hiveService: getIt()),
  );
  getIt.registerLazySingleton<MealRepo>(
    () => MealRepoImp(hiveService: getIt()),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(), getIt()));
  getIt.registerFactory<AddRestaurantCubit>(
    () => AddRestaurantCubit(getIt(), getIt()),
  );
  getIt.registerFactory<ManageRestaurantCubit>(
    () => ManageRestaurantCubit(getIt(), getIt(), getIt()),
  );
}
