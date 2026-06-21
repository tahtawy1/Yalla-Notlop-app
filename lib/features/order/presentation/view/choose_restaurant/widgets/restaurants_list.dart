import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/choose_restaurant/widgets/choosing_restaurant_card.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({
    super.key,
    required this.restaurants,
    required this.onSelect,
    required this.selectedRestaurant,
  });
  final List<RestaurantModel> restaurants;
  final Function(RestaurantModel) onSelect;
  final RestaurantModel? selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurants.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return ChoosingRestaurantCard(
          restaurant: restaurant,
          isSelected: selectedRestaurant?.id == restaurant.id,
          onTap: () => onSelect(restaurant),
        );
      },
    );
  }
}
