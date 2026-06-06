import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/meal_repo/meal_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/restaurant_management_view_body.dart';

class RestaurantManagementView extends StatelessWidget {
  const RestaurantManagementView({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageRestaurantCubit(
        RestaurantRepoImp(),
        CategoryRepoImp(),
        MealRepoImp(),
      )..initDraft(restaurant),
      child: RestaurantManagementViewBody(restaurant: restaurant),
    );
  }
}
