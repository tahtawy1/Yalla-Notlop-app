import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/view_model/add_restaurant_cubit/add_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/dashed_border_painter.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });
  final VoidCallback onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.restaurantImageLabel,
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
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: AppColors.restaurantDashedBorder,
                ),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.restaurantBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              context.read<AddRestaurantCubit>().image != null
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.upload_rounded,
                              color:
                                  context.read<AddRestaurantCubit>().image !=
                                      null
                                  ? AppColors.secondaryColor
                                  : AppColors.restaurantFieldHint,
                              size: 32,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              context.read<AddRestaurantCubit>().image != null
                                  ? AppStrings.restaurantImageAdded
                                  : AppStrings.restaurantUploadHint,
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
              ),
            );
          },
        ),
      ],
    );
  }
}
