import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/choose_restaurant/widgets/restaurants_list.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/choose_restaurant_cubit/choose_restaurant_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/primary_button.dart';

class ChooseRestaurantView extends StatelessWidget {
  const ChooseRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final chooseRestaurantCubit = context.read<ChooseRestaurantCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.chooseRestaurantTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ChooseRestaurantViewBody(
            chooseRestaurantCubit: chooseRestaurantCubit,
          ),
        ),
      ),
    );
  }
}

class ChooseRestaurantViewBody extends StatefulWidget {
  const ChooseRestaurantViewBody({
    super.key,
    required this.chooseRestaurantCubit,
  });

  final ChooseRestaurantCubit chooseRestaurantCubit;

  @override
  State<ChooseRestaurantViewBody> createState() =>
      _ChooseRestaurantViewBodyState();
}

class _ChooseRestaurantViewBodyState extends State<ChooseRestaurantViewBody> {
  bool showRestaurantValidation = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          context.l10n.chooseRestaurantTitle2,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          context.l10n.chooseRestaurantSubTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textMuted,
          ),
        ),
        SizedBox(height: 16),
        BlocBuilder<ChooseRestaurantCubit, ChooseRestaurantState>(
          builder: (context, state) {
            if (state.isLoading ?? false) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.isError ?? false) {
              return Center(child: Text(state.errorMessage ?? ""));
            }
            if (state.restaurants == null || state.restaurants!.isEmpty) {
              return Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      context.l10n.noRestaurantsAvailable,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.emptyState,
                      ),
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: RestaurantsList(
                restaurants: state.restaurants!,
                onSelect: (restaurant) {
                  showRestaurantValidation = false;
                  setState(() {});
                  widget.chooseRestaurantCubit.chooseRestaurant(restaurant);
                },
                selectedRestaurant:
                    widget.chooseRestaurantCubit.selectedRestaurant,
              ),
            );
          },
        ),
        if (showRestaurantValidation &&
            widget.chooseRestaurantCubit.selectedRestaurant == null)
          Text(
            context.l10n.selectRestaurantValidation,
            style: TextStyle(
              color: AppColors.danger,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            onTap: () {
              if (widget.chooseRestaurantCubit.selectedRestaurant == null) {
                showRestaurantValidation = true;
                setState(() {});
                return;
              }
              context.push(
                AppRoutes.members,
                extra: widget.chooseRestaurantCubit.selectedRestaurant,
              );
            },
            title: context.l10n.next,
            color: AppColors.primary,
            fontSize: 18,
            postfixIcon: context.read<LocalizationCubit>().isRtl()
                ? Icons.arrow_back
                : null,
            prefixIcon: context.read<LocalizationCubit>().isRtl()
                ? null
                : Icons.arrow_forward,
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
