import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';
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

  late AddRestaurantCubit restaurantCubit;

  bool showCategoryError = false;

  @override
  void initState() {
    super.initState();
    restaurantCubit = BlocProvider.of<AddRestaurantCubit>(context);
    // Load categories from Hive on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restaurantCubit.getCategories();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryNameController.dispose();
    mealNameController.dispose();
    mealPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddRestaurantCubit, AddRestaurantState>(
      listener: (context, state) {
        if (state is AddRestaurantSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تمت إضافة المطعم بنجاح ✓'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddRestaurantFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is AddCategorySuccess) {
          // Refresh category list in RestaurantCubit after any change
          restaurantCubit.getCategories();
        }
        if (state is GetCategoriesSuccess) {
          restaurantCubit.categories = state.categories;
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            RestaurantNameFeild(
              nameController: nameController,
              autovalidateMode: autovalidateMode,
            ),
            SizedBox(height: 20),
            BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
              buildWhen: (_, state) =>
                  state is PickRestaurantImageSuccess ||
                  state is PickRestaurantImageLoading ||
                  state is PickRestaurantImageFailure,
              builder: (context, state) {
                return ImageUploadSection(
                  isLoading: state is PickRestaurantImageLoading,
                  onTap: state is PickRestaurantImageLoading
                      ? () {}
                      : () async {
                          await context.read<AddRestaurantCubit>().pickImage();
                        },
                );
              },
            ),
            SizedBox(height: 16),
            BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
              builder: (context, state) {
                final cats = state is GetCategoriesSuccess
                    ? state.categories
                    : restaurantCubit.categories;
                return CategoriesSection(
                  categories: cats,
                  selectedCategory: restaurantCubit.selectedCategory,
                  showError: showCategoryError,
                  onSelect: (category) {
                    setState(() => showCategoryError = false);
                    restaurantCubit.selectCategory(category);
                  },
                  onAdd: (name) => restaurantCubit.addCategory(name: name),
                  categoryNameController: categoryNameController,
                );
              },
            ),
            SizedBox(height: 16),
            BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
              buildWhen: (_, state) => state is MealsUpdated,
              builder: (context, state) {
                return MealsSection(
                  meals: restaurantCubit.meals,
                  mealNameController: mealNameController,
                  mealPriceController: mealPriceController,
                  onSaveMeal: (meal) => restaurantCubit.addMeal(meal),
                  onDelete: (meal) => restaurantCubit.removeMeal(meal),
                );
              },
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
                buildWhen: (_, state) =>
                    state is AddRestaurantLoading ||
                    state is AddRestaurantSuccess ||
                    state is AddRestaurantFailure ||
                    state is AddRestaurantInitial,
                builder: (context, state) {
                  final isLoading = state is AddRestaurantLoading;
                  return PrimaryButton(
                    title: AppStrings.saveRestaurant,
                    icon: Icons.save_rounded,
                    color: AppColors.primaryColor,
                    isLoading: isLoading,
                    onTap: () {
                      final bool isCategorySelected =
                          restaurantCubit.selectedCategory != null;
                      setState(() {
                        showCategoryError = !isCategorySelected;
                      });
                      if (formKey.currentState!.validate() &&
                          isCategorySelected) {
                        BlocProvider.of<AddRestaurantCubit>(
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
