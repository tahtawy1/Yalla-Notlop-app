import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/meal_cubit/meal_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_restaurant_body.dart';
import '../../view_model/restaurant_cubit/restaurant_cubit.dart';

class AddRestaurantView extends StatelessWidget {
  const AddRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RestaurantCubit(RestaurantRepoImp())),
        BlocProvider(create: (context) => CategoryCubit(CategoryRepoImp())),

        BlocProvider(create: (context) => MealCubit(MealRepoImp())),
      ],
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: AddRestaurantBody(),
      ),
    );
  }
}
