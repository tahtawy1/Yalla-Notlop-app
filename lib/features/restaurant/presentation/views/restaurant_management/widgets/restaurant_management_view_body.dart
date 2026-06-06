import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/manage_restaurant_cubit/manage_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_meal_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_retaurant_form.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/confirm_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/danger_outlined_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_category_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_name_dialog.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/management_meal_card.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/management_meals_section.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/restaurant_hero_card.dart';

class RestaurantManagementViewBody extends StatefulWidget {
  const RestaurantManagementViewBody({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  @override
  State<RestaurantManagementViewBody> createState() =>
      _RestaurantManagementViewBodyState();
}

class _RestaurantManagementViewBodyState
    extends State<RestaurantManagementViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealPriceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    mealNameController.dispose();
    mealPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageRestaurantCubit, ManageRestaurantState>(
      listener: (context, state) {
        final cubit = context.read<ManageRestaurantCubit>();
        if (state is SaveUpdatedRestaurantFailure ||
            state is AddCategoryFailure ||
            state is PickRestaurantImageFailure ||
            state is DeleteRestaurantFailure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state is SaveUpdatedRestaurantFailure
                      ? state.errMessage
                      : state is AddCategoryFailure
                      ? state.errMessage
                      : state is PickRestaurantImageFailure
                      ? state.errMessage
                      : state is DeleteRestaurantFailure
                      ? state.errMessage
                      : 'حدث خطأ',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
        if (state is AddCategorySuccess) {
          cubit.getCategories();
        }
        if (state is GetCategoriesSuccess) {
          cubit.categories = state.categories;
        }
        if (state is DeleteRestaurantSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }
        if (state is SaveUpdatedRestaurantSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }
      },

      builder: (context, state) {
        final cubit = context.read<ManageRestaurantCubit>();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            cubit.discardChanges();
            Navigator.pop(context, result);
          },
          child: Scaffold(
            backgroundColor: AppColors.restaurantBackground,
            appBar: AppBar(
              backgroundColor: AppColors.restaurantBackground,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                AppStrings.restaurantManagementAppBar,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: IconButton(
                  onPressed: () {
                    cubit.discardChanges();
                    Navigator.maybePop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RestaurantHeroCard(
                  restaurantName: cubit.name ?? '',
                  categoryName: cubit.selectedCategory?.name ?? 'بدون قسم',
                  imagePath: cubit.image?.path ?? cubit.imagePath,
                  onEditName: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => EditNameDialog(
                        initialName: cubit.name ?? '',
                        onSaveName: (newName) {
                          cubit.changeRestaurantName(newName);
                        },
                      ),
                    );
                  },
                  onEditCategory: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => BlocProvider.value(
                        value: cubit,
                        child: EditCategoryDialog(
                          initialCategory: cubit.selectedCategory,
                          onSaveCategory: (newCategory) {
                            if (newCategory != null) {
                              cubit.selectCategory(newCategory);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  title: AppStrings.saveChanges,
                  icon: Icons.save_rounded,
                  color: AppColors.primaryColor,
                  onTap: () => cubit.saveUpdatedRestaurant(),
                ),
                const SizedBox(height: 32),
                ManagementMealsSection(
                  onAddMeal: () {
                    mealNameController.clear();
                    mealPriceController.clear();
                    showDialog(
                      context: context,
                      builder: (ctx) => AddMealDialog(
                        mealNameController: mealNameController,
                        mealPriceController: mealPriceController,
                        onSaveMeal: () {
                          final newMeal = MealModel(
                            name: mealNameController.text.trim(),
                            price: mealPriceController.text.trim(),
                          );
                          cubit.addMeal(newMeal);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ...cubit.meals.map(
                  (meal) => ManagementMealCard(
                    meal: meal,
                    onEdit: () {
                      mealNameController.text = meal.name;
                      mealPriceController.text = meal.price;
                      showDialog(
                        context: context,
                        builder: (ctx) => AddMealDialog(
                          mealNameController: mealNameController,
                          mealPriceController: mealPriceController,
                          onSaveMeal: () {
                            final newMeal = MealModel(
                              name: mealNameController.text.trim(),
                              price: mealPriceController.text.trim(),
                            );
                            cubit.updateMeal(meal, newMeal);
                          },
                        ),
                      );
                    },
                    onDelete: () {
                      cubit.removeMeal(meal);
                    },
                  ),
                ),
                const SizedBox(height: 32),
                DangerOutlinedButton(
                  onTap: () {
                    ConfirmDialog.show(
                      context,
                      title: 'حذف المطعم',
                      message:
                          'هل أنت متأكد من حذف هذا المطعم؟ لا يمكن التراجع عن هذا الإجراء.',
                      confirmText: 'حذف',
                      onConfirm: () => cubit.deleteRestaurant(
                        cubit.originalRestaurant,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}
