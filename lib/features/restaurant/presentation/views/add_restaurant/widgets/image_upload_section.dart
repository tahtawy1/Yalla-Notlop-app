import 'package:dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({
    super.key,
    required this.onTap,
    required this.onSelect,
    this.isLoading = false,
    this.selectedImage = '',
  });
  final VoidCallback onTap;
  final void Function(String) onSelect;
  final bool isLoading;
  final String? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).restaurantImage,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.splashTitleColor,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: isLoading ? null : onTap,
              child: Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.restaurantBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: DashedBorder(color: AppColors.restaurantDashedBorder),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          strokeWidth: 2,
                        ),
                      )
                    //Todo for image preview
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            context.read<AddRestaurantCubit>().image != null
                                ? Icons.check_circle_outline_rounded
                                : Icons.upload_rounded,
                            color:
                                context.read<AddRestaurantCubit>().image != null
                                ? AppColors.secondaryColor
                                : AppColors.restaurantFieldHint,
                            size: 32,
                          ),
                          SizedBox(height: 6),
                          Text(
                            context.read<AddRestaurantCubit>().image != null
                                ? S.of(context).restaurantImageAdded
                                : S.of(context).restaurantUploadHint,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color:
                                  context.read<AddRestaurantCubit>().image !=
                                      null
                                  ? AppColors.secondaryColor
                                  : AppColors.restaurantFieldHint,
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryImagePreview(
                imagePath: AppImageAssets.restaurantBreakfastCategory,
                isSelected:
                    selectedImage == AppImageAssets.restaurantBreakfastCategory,
                onSelect: () {
                  onSelect(AppImageAssets.restaurantBreakfastCategory);
                },
              ),
              CategoryImagePreview(
                imagePath: AppImageAssets.restaurantLunchCategory,
                isSelected:
                    selectedImage == AppImageAssets.restaurantLunchCategory,
                onSelect: () {
                  onSelect(AppImageAssets.restaurantLunchCategory);
                },
              ),
              CategoryImagePreview(
                imagePath: AppImageAssets.restaurantFastFoodCategory,
                isSelected:
                    selectedImage == AppImageAssets.restaurantFastFoodCategory,
                onSelect: () {
                  onSelect(AppImageAssets.restaurantFastFoodCategory);
                },
              ),
              CategoryImagePreview(
                imagePath: AppImageAssets.restaurantDesertsCategory,
                isSelected:
                    selectedImage == AppImageAssets.restaurantDesertsCategory,
                onSelect: () {
                  onSelect(AppImageAssets.restaurantDesertsCategory);
                },
              ),
              CategoryImagePreview(
                imagePath: AppImageAssets.restaurantDrinkCategory,
                isSelected:
                    selectedImage == AppImageAssets.restaurantDrinkCategory,
                onSelect: () {
                  onSelect(AppImageAssets.restaurantDrinkCategory);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          S.of(context).uploadImageOrSelectExisting,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.restaurantFieldHint,
          ),
        ),
        SizedBox(height: 6),
        Text(
          S.of(context).uploadedImagePriorityWarning,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}

class CategoryImagePreview extends StatelessWidget {
  const CategoryImagePreview({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.onSelect,
  });
  final String imagePath;
  final bool isSelected;
  final VoidCallback onSelect;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryColor
                : AppColors.restaurantDashedBorder,
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
