import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_strings.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/restaurant_header_section.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/restaurant_name_field.dart';

class AddRestaurantBody extends StatelessWidget {
  const AddRestaurantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),

      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RestaurantHeaderSection(),
            SizedBox(height: 28),
            RestaurantNameField(),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
