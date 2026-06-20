part of 'manage_categories_cubit.dart';

@immutable
sealed class ManageCategoriesState {}

final class ManageCategoriesInitial extends ManageCategoriesState {}

final class ManageCategoriesLoading extends ManageCategoriesState {}

final class ManageCategoriesLoaded extends ManageCategoriesState {
  final List<CategoryModel> categories;
  final Map<String, int> categoryUsageCount;

  ManageCategoriesLoaded({
    required this.categories,
    required this.categoryUsageCount,
  });
}

final class ManageCategoriesEmpty extends ManageCategoriesState {}

final class ManageCategoriesError extends ManageCategoriesState {
  final String message;
  ManageCategoriesError({required this.message});
}

final class ManageCategoriesActionLoading extends ManageCategoriesState {}

final class ManageCategoriesActionSuccess extends ManageCategoriesState {
  final String message;
  ManageCategoriesActionSuccess({required this.message});
}

final class ManageCategoriesActionError extends ManageCategoriesState {
  final String message;
  ManageCategoriesActionError({required this.message});
}
