import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/cancel_button.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/categories_section.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/meals_section.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/image_upload_section.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/restaurant_name_feild.dart';

class AddRetaurantForm extends StatefulWidget {
  const AddRetaurantForm({super.key});

  @override
  State<AddRetaurantForm> createState() => _AddRetaurantFormState();
}

class _AddRetaurantFormState extends State<AddRetaurantForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus;
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController mealPriceController = TextEditingController();

  late RestaurantCubit cubit;
  bool showCategoryError = false;

  @override
  void initState() {
    cubit = BlocProvider.of<RestaurantCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          RestaurantNameFeild(
            nameController: nameController,
            autovalidateMode: autovalidateMode,
          ),
          SizedBox(height: 20),
          ImageUploadSection(
            onTap: () async {
              await context.read<RestaurantCubit>().pickImage();
            },
          ),
          SizedBox(height: 16),
          BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              return CategoriesSection(
                categories: cubit.categories,
                selectedCategory: cubit.selectedCategory,
                showError: showCategoryError,
                onSelect: (category) {
                  setState(() {
                    showCategoryError = false;
                  });
                  cubit.selectCategory(category);
                },
                onAdd: (category) => cubit.addCategory(category),
                onDelete: (category) => cubit.removeCategory(category),
                categoryNameController: categoryNameController,
              );
            },
          ),
          SizedBox(height: 16),
          MealsSection(
            meals: cubit.meals,
            mealNameController: mealNameController,
            mealPriceController: mealPriceController,
            onSaveMeal: (meal) {
              cubit.addMeal(meal);
              setState(() {});
            },
            onDelete: (meal) {
              cubit.meals.remove(meal);
              setState(() {});
            },
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<RestaurantCubit, RestaurantState>(
              builder: (context, state) {
                return PrimaryButton(
                  title: AppStrings.saveRestaurant,
                  icon: Icons.save_rounded,
                  color: AppColors.secondaryColor,
                  onTap: () {
                    final bool isCategorySelected =
                        cubit.selectedCategory != null;
                    setState(() {
                      showCategoryError = !isCategorySelected;
                    });
                    if (formKey.currentState!.validate() &&
                        isCategorySelected) {
                      BlocProvider.of<RestaurantCubit>(
                        context,
                      ).addRestaurant(name: nameController.text);
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(height: 12),
          CancelButton(),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.isLoading = false,
    required this.color,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
    );
  }
}
