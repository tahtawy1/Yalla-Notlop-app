import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/widgets/meal_choosing_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/widgets/member_order_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class PassPhoneView extends StatefulWidget {
  final List<MemberModel> members;
  final RestaurantModel restaurant;
  const PassPhoneView({
    super.key,
    required this.members,
    required this.restaurant,
  });

  @override
  State<PassPhoneView> createState() => _PassPhoneViewState();
}

class _PassPhoneViewState extends State<PassPhoneView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    for (int i = 0; i < widget.members.length; i++) {
      widget.members[i] = widget.members[i].copyWith(meals: [], payedAmount: 0);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _resetAndPop() {
    context.read<OrderCubit>().resetOrder(widget.members);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final members = widget.members;
    final restaurant = widget.restaurant;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _resetAndPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            context.l10n.appName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _resetAndPop,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection: context.read<LocalizationCubit>().isRtl()
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: BlocConsumer<OrderCubit, OrderState>(
                      listener: (context, state) {
                        if (state is PassToNextMember) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else if (state is PassToPreviousMember) {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                        if (state is FinishTheOrder) {
                          context.pushReplacement(
                            AppRoutes.finishOrderView,
                            extra: {
                              'orderModel': state.orderModel,
                              'orderCubit': context.read<OrderCubit>(),
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        final cubit = context.read<OrderCubit>();
                        final member = cubit.members[index];
                        final orderMeals =
                            cubit.membersMealsOrder[member.id] ?? {};

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: member.name,
                                            style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.primary,
                                              fontFamily: 'Cairo',
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    ', ${context.l10n.yourTurn}',
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.textPrimary,
                                                  fontFamily: 'Cairo',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          context.l10n.chooseYourFavMeals,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),

                                  SliverList.builder(
                                    itemCount: restaurant.meals?.length ?? 0,
                                    itemBuilder: (context, mealIndex) {
                                      final meal = restaurant.meals![mealIndex];
                                      final mealCounter =
                                          member.meals
                                              ?.where((m) => m.id == meal.id)
                                              .length ??
                                          0;
                                      return MealChoosingCard(
                                        meal: meal,
                                        onMealAdded: () {
                                          cubit.addMealForMember(member, meal);
                                        },
                                        onMealRemoved: () {
                                          if (mealCounter > 0) {
                                            cubit.removeMealForMember(
                                              member,
                                              meal,
                                            );
                                          }
                                        },
                                        mealCounter: mealCounter,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            MemberOrderCard(
                              member: member,
                              orderMeals: orderMeals,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
