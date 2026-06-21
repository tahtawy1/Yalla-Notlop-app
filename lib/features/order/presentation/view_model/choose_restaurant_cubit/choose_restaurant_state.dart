part of 'choose_restaurant_cubit.dart';

class ChooseRestaurantState {
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;
  final List<RestaurantModel>? restaurants;
  final RestaurantModel? selectedRestaurant;

  const ChooseRestaurantState({
    this.isLoading,
    this.restaurants,
    this.selectedRestaurant,
    this.isError,
    this.errorMessage,
  });

  ChooseRestaurantState copyWith({
    List<RestaurantModel>? restaurants,
    RestaurantModel? selectedRestaurant,
    bool? isLoading,
    bool? isError,
    String? errMessage,
  }) {
    return ChooseRestaurantState(
      restaurants: restaurants,
      selectedRestaurant: selectedRestaurant,
      isLoading: isLoading,
      isError: isError,
      errorMessage: errMessage,
    );
  }
}
