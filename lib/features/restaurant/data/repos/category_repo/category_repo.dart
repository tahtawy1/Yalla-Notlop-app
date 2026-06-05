import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';

abstract class CategoryRepo {
  Future<Either<AppFailure, void>> addCategory({
    required CategoryModel category,
  });
  Future<Either<AppFailure, void>> updateCategory({
    required CategoryModel category,
  });
  Future<Either<AppFailure, void>> deleteCategory({
    required CategoryModel category,
  });
  Future<Either<AppFailure, List<CategoryModel>>> getCategories();
}
