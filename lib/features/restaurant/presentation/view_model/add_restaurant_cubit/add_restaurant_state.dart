part of 'add_restaurant_cubit.dart';

abstract class AddRestaurantState {
  const AddRestaurantState();
}

class AddRestaurantInitial extends AddRestaurantState {
  const AddRestaurantInitial();
}

class AddRestaurantLoading extends AddRestaurantState {}

class AddRestaurantSuccess extends AddRestaurantState {}

class AddRestaurantFailure extends AddRestaurantState {
  final String errMessage;
  const AddRestaurantFailure({required this.errMessage});
}

class PickRestaurantImageLoading extends AddRestaurantState {}

class PickRestaurantImageSuccess extends AddRestaurantState {
  final File image;
  const PickRestaurantImageSuccess({required this.image});
}

class PickRestaurantImageFailure extends AddRestaurantState {
  final String errMessage;
  const PickRestaurantImageFailure({required this.errMessage});
}

class MealsUpdated extends AddRestaurantState {}

class CategoryUpdated extends AddRestaurantState {}

class AddCategorySuccess extends AddRestaurantState {}

class AddCategoryFailure extends AddRestaurantState {
  final String errMessage;
  AddCategoryFailure({required this.errMessage});
}

class GetCategoriesLoading extends AddRestaurantState {}

class GetCategoriesSuccess extends AddRestaurantState {
  final List<CategoryModel> categories;
  GetCategoriesSuccess({required this.categories});
}

class ImagePathUpdated extends AddRestaurantState {}

class GetCategoriesFailure extends AddRestaurantState {
  final String errMessage;
  GetCategoriesFailure({required this.errMessage});
}
