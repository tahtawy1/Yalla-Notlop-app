import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

part 'manage_categories_state.dart';

class ManageCategoriesCubit extends Cubit<ManageCategoriesState> {
  final CategoryRepo categoryRepo;
  final RestaurantRepo restaurantRepo;

  ManageCategoriesCubit({
    required this.categoryRepo,
    required this.restaurantRepo,
  }) : super(ManageCategoriesInitial());

  Future<void> getCategories() async {
    emit(ManageCategoriesLoading());

    final categoriesResult = await categoryRepo.getCategories();
    final countResult = await restaurantRepo.getRestaurantCountPerCategory();

    categoriesResult.fold(
      (failure) => emit(ManageCategoriesError(message: failure.errMessage)),
      (categories) {
        if (categories.isEmpty) {
          emit(ManageCategoriesEmpty());
          return;
        }
        final usageCount = countResult.fold(
          (_) => <String, int>{},
          (map) => map,
        );
        emit(
          ManageCategoriesLoaded(
            categories: categories,
            categoryUsageCount: usageCount,
          ),
        );
      },
    );
  }

  Future<void> addCategory(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    if (state is ManageCategoriesLoaded) {
      final loaded = state as ManageCategoriesLoaded;
      final isDuplicate = loaded.categories.any(
        (c) => c.name.trim().toLowerCase() == trimmed.toLowerCase(),
      );
      if (isDuplicate) {
        emit(
          ManageCategoriesActionError(message: S.current.categoryAlreadyExists),
        );
        return;
      }
    }

    emit(ManageCategoriesActionLoading());
    final result = await categoryRepo.addCategory(
      category: CategoryModel(name: trimmed),
    );
    result.fold(
      (failure) =>
          emit(ManageCategoriesActionError(message: failure.errMessage)),
      (_) async {
        emit(ManageCategoriesActionSuccess(message: S.current.addCategory));
        await getCategories();
      },
    );
  }

  Future<void> editCategory(CategoryModel category, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;

    emit(ManageCategoriesActionLoading());
    final updated = category.copyWith(name: trimmed);
    final result = await categoryRepo.updateCategory(category: updated);
    result.fold(
      (failure) =>
          emit(ManageCategoriesActionError(message: failure.errMessage)),
      (_) async {
        emit(
          ManageCategoriesActionSuccess(
            message: S.current.categoryUpdateSuccess,
          ),
        );
        await getCategories();
      },
    );
  }

  Future<void> deleteCategoryIfEmpty(CategoryModel category) async {
    emit(ManageCategoriesActionLoading());
    final result = await categoryRepo.deleteCategory(category: category);
    result.fold(
      (failure) =>
          emit(ManageCategoriesActionError(message: failure.errMessage)),
      (_) async {
        emit(
          ManageCategoriesActionSuccess(
            message: S.current.categoryDeletedSuccess,
          ),
        );
        await getCategories();
      },
    );
  }

  Future<void> changeRelatedRestaurantsCategory({
    required CategoryModel oldCategory,
    required CategoryModel newCategory,
  }) async {
    emit(ManageCategoriesActionLoading());
    final moveResult = await restaurantRepo.changeRelatedRestaurantsCategory(
      oldCategory: oldCategory,
      newCategory: newCategory,
    );
    await moveResult.fold(
      (failure) async =>
          emit(ManageCategoriesActionError(message: failure.errMessage)),
      (_) async {
        final deleteResult = await categoryRepo.deleteCategory(
          category: oldCategory,
        );
        deleteResult.fold(
          (failure) =>
              emit(ManageCategoriesActionError(message: failure.errMessage)),
          (_) async {
            emit(
              ManageCategoriesActionSuccess(
                message: S.current.categoryDeletedSuccess,
              ),
            );
            await getCategories();
          },
        );
      },
    );
  }

  Future<void> forceDeleteCategoryWithRestaurants(
    CategoryModel category,
  ) async {
    emit(ManageCategoriesActionLoading());
    final result = await restaurantRepo.forceDeleteCategoryWithRestaurants(
      category: category,
    );
    result.fold(
      (failure) =>
          emit(ManageCategoriesActionError(message: failure.errMessage)),
      (_) async {
        emit(
          ManageCategoriesActionSuccess(
            message: S.current.categoryDeletedSuccess,
          ),
        );
        await getCategories();
      },
    );
  }
}
