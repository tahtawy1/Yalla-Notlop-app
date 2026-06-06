part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class AddCategoryLoading extends CategoryState {}

class AddCategorySuccess extends CategoryState {}

class AddCategoryFailure extends CategoryState {
  final String errMessage;
  AddCategoryFailure({required this.errMessage});
}

class UpdateCategoryLoading extends CategoryState {}

class UpdateCategorySuccess extends CategoryState {}

class UpdateCategoryFailure extends CategoryState {
  final String errMessage;
  UpdateCategoryFailure({required this.errMessage});
}

class DeleteCategoryLoading extends CategoryState {}

class DeleteCategorySuccess extends CategoryState {}

class DeleteCategoryFailure extends CategoryState {
  final String errMessage;
  DeleteCategoryFailure({required this.errMessage});
}

class GetCategoriesLoading extends CategoryState {}

class GetCategoriesSuccess extends CategoryState {
  final List<CategoryModel> categories;
  GetCategoriesSuccess({required this.categories});
}

class GetCategoriesFailure extends CategoryState {
  final String errMessage;
  GetCategoriesFailure({required this.errMessage});
}
