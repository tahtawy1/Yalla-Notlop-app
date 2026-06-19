import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/pass_phone_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/widgets/meal_choosing_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key, required this.restaurant, required this.member});

  final RestaurantModel restaurant;
  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurant.meals?.length ?? 0,
      itemBuilder: (context, index) {
        final meal = restaurant.meals![index];
        final mealCounter =
            member.meals?.where((m) => m.id == meal.id).length ?? 0;
        return MealChoosingCard(
          meal: meal,
          onMealAdded: () {
            context.read<OrderCubit>().addMealForMember(member, meal);
          },
          onMealRemoved: () {
            if (mealCounter > 0) {
              context.read<OrderCubit>().removeMealForMember(member, meal);
            }
          },
          mealCounter: mealCounter,
        );
      },
    );
  }
}
