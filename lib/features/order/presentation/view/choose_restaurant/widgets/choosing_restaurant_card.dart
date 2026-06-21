import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class ChoosingRestaurantCard extends StatelessWidget {
  const ChoosingRestaurantCard({
    super.key,
    required this.restaurant,
    required this.isSelected,
    required this.onTap,
  });
  final RestaurantModel restaurant;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 2,
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child:
                    restaurant.imagePath != null &&
                        restaurant.imagePath!.isNotEmpty
                    ? restaurant.imagePath!.startsWith('assets')
                          ? Image.asset(
                              restaurant.imagePath!,
                              fit: BoxFit.cover,
                              opacity: AlwaysStoppedAnimation(0.75),
                            )
                          : Image.file(
                              File(restaurant.imagePath!),
                              fit: BoxFit.cover,
                            )
                    : Container(color: AppColors.surfaceSecondary),
              ),
            ),
            Positioned(
              right: context.read<LocalizationCubit>().isRtl() ? 20 : null,
              left: context.read<LocalizationCubit>().isRtl() ? null : 20,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.glassOverlay,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (restaurant.category != null)
                      Text(
                        restaurant.category!.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
