part of 'manage_restaurant_cubit.dart';

sealed class ManageRestaurantState {}

final class ManageRestaurantInitial extends ManageRestaurantState {}

class AddCategorySuccess extends ManageRestaurantState {}

class AddCategoryFailure extends ManageRestaurantState {
  final String errMessage;
  AddCategoryFailure({required this.errMessage});
}

class CategoryUpdated extends ManageRestaurantState {}

class GetCategoriesLoading extends ManageRestaurantState {}

class GetCategoriesSuccess extends ManageRestaurantState {
  final List<CategoryModel> categories;
  GetCategoriesSuccess({required this.categories});
}

class DeleteCategoryLoading extends ManageRestaurantState {}

class DeleteCategorySuccess extends ManageRestaurantState {}

class DeleteCategoryFailure extends ManageRestaurantState {
  final String errMessage;
  DeleteCategoryFailure({required this.errMessage});
}

class MealsUpdated extends ManageRestaurantState {}

class SaveUpdatedRestaurantLoading extends ManageRestaurantState {}

class SaveUpdatedRestaurantSuccess extends ManageRestaurantState {
  final String message;
  SaveUpdatedRestaurantSuccess({required this.message});
}

class SaveUpdatedRestaurantFailure extends ManageRestaurantState {
  final String errMessage;
  SaveUpdatedRestaurantFailure({required this.errMessage});
}

class PickRestaurantImageLoading extends ManageRestaurantState {}

class PickRestaurantImageSuccess extends ManageRestaurantState {
  final File image;
  PickRestaurantImageSuccess({required this.image});
}

class PickRestaurantImageFailure extends ManageRestaurantState {
  final String errMessage;
  PickRestaurantImageFailure({required this.errMessage});
}

class DeleteRestaurantLoading extends ManageRestaurantState {}

class DeleteRestaurantSuccess extends ManageRestaurantState {
  final String message;
  DeleteRestaurantSuccess({required this.message});
}

class DeleteRestaurantFailure extends ManageRestaurantState {
  final String errMessage;
  DeleteRestaurantFailure({required this.errMessage});
}

class RestaurantNameUpdated extends ManageRestaurantState {
  final String name;
  RestaurantNameUpdated({required this.name});
}
