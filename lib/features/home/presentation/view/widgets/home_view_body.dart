import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/category_filter_list.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/home_header.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/restaurant_list.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_state.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (state is HomeError) {
          log(state.errMessage);
          return Center(child: Text(state.errMessage));
        }

        if (state is HomeLoaded) {
          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () => context.read<HomeCubit>().loadHomeData(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HomeHeader(
                    onRestaurantAdded: () =>
                        context.read<HomeCubit>().loadHomeData(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CategoryFilterList(
                    categories: state.categories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (category) {
                      context.read<HomeCubit>().filterByCategory(category);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: RestaurantList(restaurants: state.restaurants),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
