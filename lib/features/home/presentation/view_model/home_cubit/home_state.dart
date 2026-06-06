import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<RestaurantModel> restaurants;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  const HomeLoaded({
    required this.restaurants,
    required this.categories,
    this.selectedCategory,
  });

  HomeLoaded copyWith({
    List<RestaurantModel>? restaurants,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    bool clearSelectedCategory = false,
  }) {
    return HomeLoaded(
      restaurants: restaurants ?? this.restaurants,
      categories: categories ?? this.categories,
      selectedCategory: clearSelectedCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
    );
  }
}

class HomeError extends HomeState {
  final String errMessage;
  const HomeError({required this.errMessage});
}
