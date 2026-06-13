import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/add_retaurant_form.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/restaurant_header_section.dart';

class AddRestaurantView extends StatelessWidget {
  const AddRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 10,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.addRestaurantAppBar,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        shadowColor: AppColors.primaryColor.withAlpha(50),
        scrolledUnderElevation: 10,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RestaurantHeaderSection(),
              const SizedBox(height: 28),
              const AddRetaurantForm(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
