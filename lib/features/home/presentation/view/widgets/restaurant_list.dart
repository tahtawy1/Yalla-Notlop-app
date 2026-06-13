import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/restaurant_card.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key, required this.restaurants});

  final List<RestaurantModel> restaurants;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            AppStrings.noRestaurantsAvailable,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restaurants.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return RestaurantCard(
          restaurant: restaurants[index],
          onTap: () async {
            final result = await context.push(
              '/restaurant-management',
              extra: restaurants[index],
            );
            if (result == true) {
              if (context.mounted) {
                context.read<HomeCubit>().loadHomeData();
              }
            }
          },
        );
      },
    );
  }
}
