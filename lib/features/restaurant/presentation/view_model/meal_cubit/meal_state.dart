part of 'meal_cubit.dart';

sealed class MealState {}

final class MealInitial extends MealState {}

class AddMealLoading extends MealState {}

class AddMealSuccess extends MealState {}

class AddMealFailure extends MealState {
  final String errMessage;
  AddMealFailure({required this.errMessage});
}

class UpdateMealLoading extends MealState {}

class UpdateMealSuccess extends MealState {}

class UpdateMealFailure extends MealState {
  final String errMessage;
  UpdateMealFailure({required this.errMessage});
}

class DeleteMealLoading extends MealState {}

class DeleteMealSuccess extends MealState {}

class DeleteMealFailure extends MealState {
  final String errMessage;
  DeleteMealFailure({required this.errMessage});
}

class GetMealsLoading extends MealState {}

class GetMealsSuccess extends MealState {
  final List<MealModel> meals;
  GetMealsSuccess({required this.meals});
}

class GetMealsFailure extends MealState {
  final String errMessage;
  GetMealsFailure({required this.errMessage});
}

class PickImageLoading extends MealState {}

class PickImageSuccess extends MealState {
  final File image;
  PickImageSuccess({required this.image});
}

class PickImageFailure extends MealState {
  final String errMessage;
  PickImageFailure({required this.errMessage});
}
