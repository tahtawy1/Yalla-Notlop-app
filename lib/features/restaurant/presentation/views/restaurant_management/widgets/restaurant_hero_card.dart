import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';

class RestaurantHeroCard extends StatelessWidget {
  const RestaurantHeroCard({
    super.key,
    required this.restaurantName,
    required this.categoryName,
    required this.onEditName,
    required this.onEditCategory,
    required this.onEditImage,
    this.imagePath,
  });

  final String restaurantName;
  final String categoryName;
  final String? imagePath;
  final VoidCallback onEditName;
  final VoidCallback onEditCategory;
  final VoidCallback onEditImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: AppColors.primary.withAlpha(25),
        image: imagePath != null && imagePath!.isNotEmpty
            ? DecorationImage(
                opacity: 0.8,
                image: imagePath!.startsWith('assets')
                    ? AssetImage(imagePath!) as ImageProvider
                    : FileImage(File(imagePath!)) as ImageProvider,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            right: context.read<LocalizationCubit>().isRtl() ? null : 20,
            left: context.read<LocalizationCubit>().isRtl() ? 20 : null,
            child: InkWell(
              onTap: onEditImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.glassOverlay,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            right: context.read<LocalizationCubit>().isRtl() ? 20 : null,
            left: context.read<LocalizationCubit>().isRtl() ? null : 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.glassOverlay,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: onEditName,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: onEditCategory,
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
