// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:yalla_notlop_app/core/theme/app_colors.dart';
// import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/add_restaurant_view.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/restaurant_management_view.dart';

// class TestRestaurantsView extends StatelessWidget {
//   const TestRestaurantsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('شاشة اختبار المطاعم'),
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: ValueListenableBuilder<Box<RestaurantModel>>(
//         valueListenable: Hive.box<RestaurantModel>(
//           "restaurantsBox",
//         ).listenable(),
//         builder: (context, box, _) {
//           if (box.isEmpty) {
//             return const Center(
//               child: Text('لا يوجد مطاعم، قم بإضافة مطعم جديد.'),
//             );
//           }

//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final restaurant = box.getAt(index);
//               if (restaurant == null) return const SizedBox();
//               log(restaurant.meals?[0].name.toString() ?? "No meals");
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: ListTile(
//                   title: Text(
//                     restaurant.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'القسم: ${restaurant.category?.name ?? "بدون"} - الوجبات: ${restaurant.meals?.length ?? 0}',
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     // Navigate to management screen. Currently it edits index 0 by default.
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RestaurantManagementView(),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddRestaurantView()),
//           );
//         },
//         backgroundColor: AppColors.primaryColor,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text('إضافة مطعم', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }
