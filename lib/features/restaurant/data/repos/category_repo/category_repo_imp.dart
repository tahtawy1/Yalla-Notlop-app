import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/restaurant_hive_service.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class CategoryRepoImp implements CategoryRepo {
  final RestaurantHiveService hiveService;

  CategoryRepoImp({required this.hiveService});
  @override
  Future<Either<AppFailure, void>> addCategory({
    required CategoryModel category,
  }) async {
    try {
      await hiveService.addCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.addCategoryError));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      await hiveService.updateCategory(category);

      final restaurants = hiveService.getRestaurants();
      for (var restaurant in restaurants) {
        if (restaurant.category?.id == category.id) {
          final updatedRestaurant = restaurant.copyWith(category: category);
          await hiveService.updateRestaurant(updatedRestaurant);
        }
      }

      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.updateCategoryError));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteCategory({
    required CategoryModel category,
  }) async {
    try {
      await hiveService.deleteCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure(S.current.deleteCategoryError));
    }
  }

  @override
  Future<Either<AppFailure, List<CategoryModel>>> getCategories() async {
    try {
      return right(hiveService.getCategories());
    } catch (e) {
      return Left(AppFailure(S.current.fetchCategoriesError));
    }
  }
}
