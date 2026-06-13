import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';

class CategoryRepoImp implements CategoryRepo {
  final HiveService hiveService;

  CategoryRepoImp({required this.hiveService});
  //* Category ========================
  @override
  Future<Either<AppFailure, void>> addCategory({
    required CategoryModel category,
  }) async {
    try {
      await hiveService.addCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure(AppStrings.addCategoryError));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      await hiveService.updateCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure(AppStrings.updateCategoryError));
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
      return Left(AppFailure(AppStrings.deleteCategoryError));
    }
  }

  @override
  Future<Either<AppFailure, List<CategoryModel>>> getCategories() async {
    try {
      return right(hiveService.getCategories());
    } catch (e) {
      return Left(AppFailure(AppStrings.getCategoriesError));
    }
  }
}
