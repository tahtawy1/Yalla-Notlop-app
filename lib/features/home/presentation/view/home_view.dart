import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/category_filter_list.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/home_header.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/restaurant_list.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is HomeFailure) {
          return Center(child: Text(state.errMessage));
        }

        if (state is HomeLoaded) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HomeHeader(
                  onRestaurantAdded: () =>
                      context.read<HomeCubit>().loadHomeData(),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                delegate: _SliverHeaderDelegate(state: state),
              ),
              SliverToBoxAdapter(
                child: RestaurantList(restaurants: state.restaurants),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _AddRestaurantButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return ElevatedButton(
      onPressed: () async {
        final result = await context.push(AppRoutes.addRestaurant);
        if (result == true) {
          cubit.loadHomeData();
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(100, 50),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_circle_outline_rounded, color: AppColors.surface, size: 20),
          SizedBox(width: 8),
          Text(
            context.l10n.addRestaurant,
            style: TextStyle(
              color: AppColors.surface,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final HomeLoaded state;

  _SliverHeaderDelegate({required this.state});
  @override
  double get minExtent => 180;

  @override
  double get maxExtent => 180;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 42),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _AddRestaurantButton(),
          ),
          SizedBox(height: 22),
          CategoryFilterList(
            categories: state.categories,
            selectedCategory: state.selectedCategory,
            onCategorySelected: (category) {
              context.read<HomeCubit>().filterByCategory(category);
            },
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) => true;
}
