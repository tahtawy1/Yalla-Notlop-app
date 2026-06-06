import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/category_repo/category_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_restaurant_body.dart';
import '../../view_model/add_restaurant_cubit/add_restaurant_cubit.dart';

class AddRestaurantView extends StatelessWidget {
  const AddRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddRestaurantCubit(RestaurantRepoImp(), CategoryRepoImp()),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: AddRestaurantBody(),
      ),
    );
  }
}
