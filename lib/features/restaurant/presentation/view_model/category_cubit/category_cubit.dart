import 'package:bloc/bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.repo) : super(CategoryInitial());
  final CategoryRepo repo;
  Future<void> addCategory({required String name}) async {
    emit(AddCategoryLoading());
    final res = await repo.addCategory(category: _buildCategory(name));
    res.fold(
      (failure) => emit(AddCategoryFailure(errMessage: failure.errMessage)),
      (r) => emit(AddCategorySuccess()),
    );
  }

  Future<void> deleteCategory({required CategoryModel category}) async {
    emit(DeleteCategoryLoading());
    final result = await repo.deleteCategory(category: category);
    result.fold(
      (failure) => emit(DeleteCategoryFailure(errMessage: failure.errMessage)),
      (r) => emit(DeleteCategorySuccess()),
    );
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final result = await repo.getCategories();
    result.fold(
      (failure) => emit(GetCategoriesFailure(errMessage: failure.errMessage)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }

  CategoryModel _buildCategory(String name) {
    return CategoryModel(name: name);
  }
}
