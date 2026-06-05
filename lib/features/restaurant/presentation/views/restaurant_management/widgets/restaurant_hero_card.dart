import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';

class RestaurantHeroCard extends StatelessWidget {
  const RestaurantHeroCard({
    super.key,
    required this.restaurantName,
    required this.categoryName,
    required this.onEditName,
    required this.onEditCategory,
    this.imagePath,
  });

  final String restaurantName;
  final String categoryName;
  final String? imagePath;
  final VoidCallback onEditName;
  final VoidCallback onEditCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: AppColors.primaryColor.withAlpha(25),
        image: DecorationImage(
          opacity: 0.7,
          image: imagePath != null && imagePath!.isNotEmpty
              ? FileImage(File(imagePath!)) as ImageProvider
              : const AssetImage(AppImageAssets.restaurantDefaultImg),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 20,
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
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: onEditName,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.restaurantTextMuted,
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.restaurantTextMuted,
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: onEditCategory,
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: AppColors.restaurantTextMuted,
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
