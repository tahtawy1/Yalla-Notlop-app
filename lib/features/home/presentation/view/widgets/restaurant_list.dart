import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/restaurant_card.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key, required this.restaurants});

  final List<RestaurantModel> restaurants;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            context.l10n.noRestaurantsAvailable,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.emptyState,
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
        final restaurant = restaurants[index];
        return RestaurantCard(
          restaurant: restaurant,
          onCardTap: () async {
            final result = await context.push(
              AppRoutes.restaurantManagement,
              extra: restaurant,
            );
            if (result == true) {
              if (context.mounted) {
                context.read<HomeCubit>().loadHomeData();
              }
            }
          },
          onStartOrderTap: () {
            context.push(AppRoutes.members, extra: restaurant);
          },
        );
      },
    );
  }
}
