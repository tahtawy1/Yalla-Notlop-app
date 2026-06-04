part of 'restaurant_cubit.dart';

abstract class RestaurantState {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

class RestaurantAdding extends RestaurantState {}

class RestaurantAddedSuccess extends RestaurantState {}

class RestaurantAddedFailure extends RestaurantState {
  final String errMessage;
  const RestaurantAddedFailure({required this.errMessage});
}

class RestaurantCategoryChanged extends RestaurantState {}

class RestaurantImagePicked extends RestaurantState {
  final File image;
  const RestaurantImagePicked({required this.image});
}

class RestaurantImagePickedFailure extends RestaurantState {
  final String errMessage;
  const RestaurantImagePickedFailure({required this.errMessage});
}
