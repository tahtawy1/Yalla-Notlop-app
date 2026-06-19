import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/layout/layout.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/choose_restaurant/choose_restaurant_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/member/members_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/order/finish_order_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/choose_restaurant_cubit/choose_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/pass_phone_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
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
    GoRoute(
      path: '/members',
      builder: (context, state) {
        final restaurant = state.extra as RestaurantModel;
        return BlocProvider<MemberCubit>(
          create: (context) => getIt<MemberCubit>()..getMembers(),
          child: MembersView(restaurant: restaurant),
        );
      },
    ),
    GoRoute(
      path: '/pass-phone-view',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final cubit = data['orderCubit'] as OrderCubit;
        return BlocProvider<OrderCubit>.value(
          value: cubit,
          child: PassPhoneView(
            members: data['members'] as List<MemberModel>,
            restaurant: data['restaurant'] as RestaurantModel,
          ),
        );
      },
    ),
    GoRoute(
      path: '/choose-restaurant-view',
      builder: (context, state) => BlocProvider<ChooseRestaurantCubit>(
        create: (context) => getIt<ChooseRestaurantCubit>()..getRestaurants(),
        child: ChooseRestaurantView(),
      ),
    ),
    GoRoute(
      path: '/finish-order-view',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return BlocProvider<OrderCubit>.value(
          value: data['orderCubit'] as OrderCubit,
          child: FinishOrderView(order: data['orderModel'] as OrderModel),
        );
      },
    ),
  ],
);
