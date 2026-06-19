import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
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
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            S.of(context).noRestaurantsAvailable,
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
        final restaurant = restaurants[index];
        return RestaurantCard(
          restaurant: restaurant,
          onCardTap: () async {
            final result = await context.push(
              '/restaurant-management',
              extra: restaurant,
            );
            if (result == true) {
              if (context.mounted) {
                context.read<HomeCubit>().loadHomeData();
              }
            }
          },
          onStartOrderTap: () {
            context.push('/members', extra: restaurant);
          },
        );
      },
    );
  }
}
