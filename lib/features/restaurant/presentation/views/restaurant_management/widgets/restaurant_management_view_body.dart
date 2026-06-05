// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yalla_notlop_app/core/constants/app_strings.dart';
// import 'package:yalla_notlop_app/core/theme/app_colors.dart';
// import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/restaurant_cubit/restaurant_cubit.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meal_dialog.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_retaurant_form.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/danger_outlined_button.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_category_dialog.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_name_dialog.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/management_meal_card.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/management_meals_section.dart';
// import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/restaurant_hero_card.dart';

// class RestaurantManagementViewBody extends StatefulWidget {
//   const RestaurantManagementViewBody({super.key});

//   @override
//   State<RestaurantManagementViewBody> createState() =>
//       _RestaurantManagementViewBodyState();
// }

// class _RestaurantManagementViewBodyState
//     extends State<RestaurantManagementViewBody> {
//   final TextEditingController mealNameController = TextEditingController();
//   final TextEditingController mealPriceController = TextEditingController();

//   @override
//   void dispose() {
//     mealNameController.dispose();
//     mealPriceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RestaurantCubit, RestaurantState>(
//       listener: (context, state) {
//         if (state is RestaurantManagementSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: AppColors.successColor,
//             ),
//           );
//         } else if (state is RestaurantManagementError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errMessage),
//               backgroundColor: AppColors.dangerColor,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is RestaurantManagementLoading) {
//           return const Scaffold(
//             backgroundColor: AppColors.restaurantBackground,
//             body: Center(
//               child: CircularProgressIndicator(color: AppColors.primaryColor),
//             ),
//           );
//         } else if (state is RestaurantManagementEmpty) {
//           return const Scaffold(
//             backgroundColor: AppColors.restaurantBackground,
//             body: Center(
//               child: Text(
//                 'لا يوجد مطعم مضاف بعد',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.splashTitleColor,
//                 ),
//               ),
//             ),
//           );
//         }

//         final cubit = context.read<RestaurantCubit>();
//         final restaurant = cubit.restaurantToEdit;

//         if (restaurant == null) {
//           return const Scaffold(
//             backgroundColor: AppColors.restaurantBackground,
//             body: Center(
//               child: Text(
//                 'حدث خطأ غير متوقع',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.dangerColor,
//                 ),
//               ),
//             ),
//           );
//         }

//         final mealsList = restaurant.meals ?? [];

//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Scaffold(
//             backgroundColor: AppColors.restaurantBackground,
//             appBar: AppBar(
//               backgroundColor: AppColors.restaurantBackground,
//               elevation: 0,
//               centerTitle: true,
//               automaticallyImplyLeading: false,
//               title: const Text(
//                 AppStrings.restaurantManagementAppBar,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               leading: Padding(
//                 padding: const EdgeInsetsDirectional.only(start: 8),
//                 child: IconButton(
//                   onPressed: () => Navigator.maybePop(context),
//                   icon: const Icon(
//                     Icons.arrow_forward_rounded,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   RestaurantHeroCard(
//                     restaurantName: restaurant.name,
//                     categoryName: restaurant.category?.name ?? 'بدون قسم',
//                     imagePath: restaurant.imagePath,
//                     onEditName: () {
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => EditNameDialog(
//                           initialName: restaurant.name,
//                           onSaveName: (newName) {
//                             cubit.updateEditName(newName);
//                           },
//                         ),
//                       );
//                     },
//                     onEditCategory: () {
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => EditCategoryDialog(
//                           initialCategory: restaurant.category,
//                           onSaveCategory: (newCategory) {
//                             cubit.updateEditCategory(newCategory);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   PrimaryButton(
//                     title: AppStrings.saveChanges,
//                     icon: Icons.save_rounded,
//                     color: AppColors.primaryColor,
//                     onTap: () => cubit.saveEditedRestaurant(),
//                   ),
//                   const SizedBox(height: 32),
//                   ManagementMealsSection(
//                     onAddMeal: () {
//                       mealNameController.clear();
//                       mealPriceController.clear();
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => AddMealDialog(
//                           mealNameController: mealNameController,
//                           mealPriceController: mealPriceController,
//                           onSaveMeal: () {
//                             final newMeal = MealModel(
//                               name: mealNameController.text.trim(),
//                               price: mealPriceController.text.trim(),
//                             );
//                             cubit.addMealToEdit(newMeal);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   ...mealsList.map(
//                     (meal) => ManagementMealCard(
//                       meal: meal,
//                       onEdit: () {
//                         mealNameController.text = meal.name;
//                         mealPriceController.text = meal.price;
//                         showDialog(
//                           context: context,
//                           builder: (ctx) => AddMealDialog(
//                             mealNameController: mealNameController,
//                             mealPriceController: mealPriceController,
//                             onSaveMeal: () {
//                               final newMeal = MealModel(
//                                 name: mealNameController.text.trim(),
//                                 price: mealPriceController.text.trim(),
//                               );
//                               cubit.updateMealToEdit(meal, newMeal);
//                             },
//                           ),
//                         );
//                       },
//                       onDelete: () {
//                         cubit.removeMealFromEdit(meal);
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   DangerOutlinedButton(
//                     onTap: () => cubit.deleteEditedRestaurant(),
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
