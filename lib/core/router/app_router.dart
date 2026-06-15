import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/home_view.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/layout/layout.dart';
import 'package:yalla_notlop_app/features/member/presentation/view/members_view.dart';
import 'package:yalla_notlop_app/features/member/presentation/view_model/cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/add_restaurant_view.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/restaurant_management_view.dart';
import 'package:yalla_notlop_app/features/splash/views/splash_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashView()),
    GoRoute(
      path: '/home',
      builder: (context, state) => BlocProvider<HomeCubit>(
        create: (context) => getIt<HomeCubit>()..loadHomeData(),
        child: Layout(),
      ),
    ),
    GoRoute(
      path: '/add-restaurant',
      builder: (context, state) => BlocProvider<AddRestaurantCubit>(
        create: (context) => getIt<AddRestaurantCubit>(),
        child: AddRestaurantView(),
      ),
    ),

    GoRoute(
      path: '/restaurant-management',
      builder: (context, state) {
        final restaurant = state.extra as RestaurantModel;
        return BlocProvider<ManageRestaurantCubit>(
          create: (context) =>
              getIt<ManageRestaurantCubit>()..initDraft(restaurant),
          child: RestaurantDetailsView(restaurant: restaurant),
        );
      },
    ),
    // GoRoute(
    //   path: '/members',
    //   builder: (context, state) => BlocProvider<MemberCubit>(
    //     create: (context) => getIt<MemberCubit>()..getMembers(),
    //     child: MembersView(),
    //   ),
    // ),
  ],
);
