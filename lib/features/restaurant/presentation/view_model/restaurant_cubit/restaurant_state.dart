part of 'restaurant_cubit.dart';

abstract class RestaurantState {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

class AddRestaurantLoading extends RestaurantState {}

class AddRestaurantSuccess extends RestaurantState {}

class AddRestaurantFailure extends RestaurantState {
  final String errMessage;
  const AddRestaurantFailure({required this.errMessage});
}

class PickRestaurantImageLoading extends RestaurantState {}

class PickRestaurantImageSuccess extends RestaurantState {
  final File image;
  const PickRestaurantImageSuccess({required this.image});
}

class PickRestaurantFailure extends RestaurantState {
  final String errMessage;
  const PickRestaurantFailure({required this.errMessage});
}

class MealsUpdated extends RestaurantState {}

class CategoryUpdated extends RestaurantState {}
