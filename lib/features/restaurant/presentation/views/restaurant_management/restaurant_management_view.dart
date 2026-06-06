// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yalla_notlop_app/features/restaurant/data/repos/restaurant_repo/restaurant_repo_imp.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/restaurant_cubit/restaurant_cubit.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/restaurant_management_view_body.dart';

// class RestaurantManagementView extends StatelessWidget {
//   const RestaurantManagementView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           RestaurantCubit(RestaurantRepoImp())..loadRestaurantToEdit(),
//       child: const RestaurantManagementViewBody(),
//     );
//   }
// }
