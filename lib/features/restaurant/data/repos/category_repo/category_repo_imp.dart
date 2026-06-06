import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/services/hive_service.dart';

class CategoryRepoImp implements CategoryRepo {
  //* Category ========================
  @override
  Future<Either<AppFailure, void>> addCategory({
    required CategoryModel category,
  }) async {
    try {
      await HiveService().addCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في إضافة الفئة'));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      await HiveService().updateCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في تحديث الفئة'));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteCategory({
    required CategoryModel category,
  }) async {
    try {
      await HiveService().deleteCategory(category);
      return right(null);
    } catch (e) {
      return Left(AppFailure('حدث خطأ في حذف الفئة'));
    }
  }

  @override
  Future<Either<AppFailure, List<CategoryModel>>> getCategories() async {
    try {
      return right(HiveService().getCategories());
    } catch (e) {
      return Left(AppFailure('حدث خطأ في جلب الفئات'));
    }
  }
}
