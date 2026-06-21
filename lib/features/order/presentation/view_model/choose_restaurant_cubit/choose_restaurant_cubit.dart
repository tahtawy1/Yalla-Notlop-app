import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo.dart';

part 'choose_restaurant_state.dart';

class ChooseRestaurantCubit extends Cubit<ChooseRestaurantState> {
  ChooseRestaurantCubit(this.restaurantRepo) : super(ChooseRestaurantState());
  final RestaurantRepo restaurantRepo;
  RestaurantModel? selectedRestaurant;
  List<RestaurantModel> restaurants = [];
  Future<void> getRestaurants() async {
    emit(state.copyWith(isLoading: true, errMessage: null, isError: false));
    final result = await restaurantRepo.getRestaurants();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errMessage: failure.errMessage,
          isError: true,
        ),
      ),
      (newRestaurants) {
        restaurants = newRestaurants;
        emit(
          state.copyWith(
            restaurants: restaurants,
            isLoading: false,
            isError: false,
            errMessage: null,
          ),
        );
      },
    );
  }

  void chooseRestaurant(RestaurantModel restaurant) {
    selectedRestaurant = restaurant;
    emit(
      state.copyWith(selectedRestaurant: restaurant, restaurants: restaurants),
    );
  }
}
