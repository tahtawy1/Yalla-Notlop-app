import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/member/data/repos/member_repo.dart';
import 'package:yalla_notlop_app/features/member/data/repos/member_repo_imp.dart';
import 'package:yalla_notlop_app/features/member/data/services/member_hive_services.dart';
import 'package:yalla_notlop_app/features/member/presentation/view_model/cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/restaurant_hive_service.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocators() async {
  getIt.registerLazySingleton(
    () => Hive.box<RestaurantModel>("restaurantsBox"),
  );

  getIt.registerLazySingleton(() => Hive.box<CategoryModel>("categoriesBox"));
  getIt.registerLazySingleton(() => Hive.box<MemberModel>("membersBox"));

  getIt.registerLazySingleton(
    () => RestaurantHiveService(restaurantsBox: getIt(), categoryBox: getIt()),
  );
  getIt.registerLazySingleton(() => MemberHiveServices(membersBox: getIt()));
  getIt.registerLazySingleton<RestaurantRepo>(
    () => RestaurantRepoImp(hiveService: getIt()),
  );
  getIt.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImp(hiveService: getIt()),
  );
  getIt.registerLazySingleton<MealRepo>(
    () => MealRepoImp(hiveService: getIt()),
  );
  getIt.registerLazySingleton<MemberRepo>(
    () => MemberRepoImp(hiveService: getIt()),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(), getIt()));
  getIt.registerFactory<AddRestaurantCubit>(
    () => AddRestaurantCubit(getIt(), getIt()),
  );
  getIt.registerFactory<ManageRestaurantCubit>(
    () => ManageRestaurantCubit(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<MemberCubit>(() => MemberCubit(getIt()));
}
