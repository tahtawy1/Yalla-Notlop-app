import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_state.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.restaurantRepo, this.categoryRepo)
    : super(const HomeInitial());

  final RestaurantRepo restaurantRepo;
  final CategoryRepo categoryRepo;

  List<RestaurantModel> _allRestaurants = [];

  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    // Load categories
    List<CategoryModel> loadedCategories = [];
    final categoryRes = await categoryRepo.getCategories();
    categoryRes.fold((failure) {}, (categories) {
      loadedCategories = categories;
    });

    // Load restaurants
    final res = await restaurantRepo.getRestaurants();
    res.fold((failure) => emit(HomeFailure(errMessage: failure.errMessage)), (
      restaurants,
    ) {
      _allRestaurants = restaurants;
      emit(
        HomeLoaded(restaurants: _allRestaurants, categories: loadedCategories),
      );
    });
  }

  void filterByCategory(CategoryModel? category) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      List<RestaurantModel> filteredRestaurants;
      if (category == null) {
        filteredRestaurants = _allRestaurants;
      } else {
        filteredRestaurants = _allRestaurants.where((restaurant) {
          return restaurant.category?.id == category.id;
        }).toList();
      }

      emit(
        currentState.copyWith(
          restaurants: filteredRestaurants,
          selectedCategory: category,
          clearSelectedCategory: category == null,
        ),
      );
    }
  }
}
