import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/core/constants/hive_boxes.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/member_repo/member_repo.dart';
import 'package:yalla_notlop_app/features/order/data/repos/member_repo/member_repo_imp.dart';
import 'package:yalla_notlop_app/features/order/data/services/member_hive_services.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/choose_restaurant_cubit/choose_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/order_repo/order_repo.dart';
import 'package:yalla_notlop_app/features/order/data/repos/order_repo/order_repo_imp.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_history_cubit/order_history_cubit.dart';
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
import 'package:yalla_notlop_app/features/order/data/repos/share_repo/share_repo.dart';
import 'package:yalla_notlop_app/features/order/data/repos/share_repo/share_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_categories_cubit/manage_categories_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocators() async {
  getIt.registerLazySingleton(
    () => Hive.box<RestaurantModel>(HiveBoxes.restaurantsBox),
  );

  getIt.registerLazySingleton(
    () => Hive.box<CategoryModel>(HiveBoxes.categoriesBox),
  );
  getIt.registerLazySingleton(
    () => Hive.box<MemberModel>(HiveBoxes.membersBox),
  );
  getIt.registerLazySingleton(() => Hive.box<OrderModel>(HiveBoxes.ordersBox));
  getIt.registerLazySingleton(
    () => Hive.box<OrderModel>(HiveBoxes.orderHistoryBox),
    instanceName: 'historyBox',
  );

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

  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImp(historyBox: getIt(instanceName: 'historyBox')),
  );

  getIt.registerLazySingleton<ShareRepo>(() => ShareRepoImp());

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(), getIt()));
  getIt.registerFactory<AddRestaurantCubit>(
    () => AddRestaurantCubit(getIt(), getIt()),
  );
  getIt.registerFactory<ManageRestaurantCubit>(
    () => ManageRestaurantCubit(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<MemberCubit>(() => MemberCubit(getIt()));
  getIt.registerFactory<ChooseRestaurantCubit>(
    () => ChooseRestaurantCubit(getIt()),
  );
  getIt.registerFactory<OrderCubit>(() => OrderCubit(getIt(), getIt()));
  getIt.registerFactory<OrderHistoryCubit>(
    () => OrderHistoryCubit(orderRepo: getIt()),
  );
  getIt.registerFactory<ManageCategoriesCubit>(
    () => ManageCategoriesCubit(categoryRepo: getIt(), restaurantRepo: getIt()),
  );
}
