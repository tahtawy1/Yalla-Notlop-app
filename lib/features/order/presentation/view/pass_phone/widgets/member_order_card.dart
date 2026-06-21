import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/widgets/pay_button.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/primary_button.dart';
import 'package:yalla_notlop_app/shared/widgets/mini_field.dart';

class MemberOrderCard extends StatefulWidget {
  const MemberOrderCard({
    super.key,
    required this.member,
    required this.orderMeals,
  });
  final MemberModel member;
  final Map<MealModel, int> orderMeals;

  @override
  State<MemberOrderCard> createState() => _MemberOrderCardState();
}

class _MemberOrderCardState extends State<MemberOrderCard> {
  bool mealsValidation = false;
  bool openField = false;
  bool customBtnSelected = false;
  bool payValidation = false;
  TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.secondary.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.l10n.totalYourOrder,
              style: const TextStyle(color: AppColors.primary, fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),

          if (widget.orderMeals.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView(
                padding: EdgeInsets.zero,
                children: widget.orderMeals.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              "${e.value} × ${e.key.name}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${double.parse(e.key.price) * e.value} ${context.l10n.mealPriceSuffix}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: [
              PayButton(
                title: context.l10n.payFullCostBtnTitle,
                onTap: () {
                  FocusScope.of(context).unfocus();

                  if (widget.orderMeals.isEmpty) {
                    setState(() => mealsValidation = true);
                    return;
                  }
                  setState(() {
                    mealsValidation = false;
                    payValidation = false;
                    openField = false;
                  });
                  orderCubit.selectPayOption(member: widget.member, index: 0);
                  FocusScope.of(context).unfocus();
                },
                isSelected: orderCubit.selectedPayOption == 0,
              ),
              !openField
                  ? PayButton(
                      title: context.l10n.payCustomCostBtnTitle,
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (widget.orderMeals.isEmpty) {
                          setState(() => mealsValidation = true);
                          return;
                        }
                        setState(() {
                          mealsValidation = false;
                          openField = true;
                        });
                      },
                      isSelected: orderCubit.selectedPayOption == 1,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            if (widget.orderMeals.isEmpty) {
                              FocusScope.of(context).unfocus();
                              setState(() => mealsValidation = true);
                              return;
                            }
                            setState(() {
                              mealsValidation = false;
                              payValidation = false;
                            });
                            final formState = formKey.currentState;
                            if (formState != null && formState.validate()) {
                              orderCubit.selectPayOption(
                                member: widget.member,
                                index: 1,
                                amount: double.parse(amountController.text),
                              );
                            }
                            setState(() => customBtnSelected = true);
                            if (mounted) {
                              Future.delayed(
                                const Duration(milliseconds: 1000),
                                () => setState(() => customBtnSelected = false),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customBtnSelected
                                  ? AppColors.primary.withAlpha(50)
                                  : AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: AppColors.surface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Form(
                          key: formKey,
                          child: SizedBox(
                            height: 36,
                            width: 100,
                            child: MiniField(
                              hintText: '',
                              controller: amountController,
                              wantValidation: false,
                              isPrice: true,
                            ),
                          ),
                        ),
                      ],
                    ),
              PayButton(
                title: context.l10n.payZeroCostBtnTitle,
                onTap: () {
                  FocusScope.of(context).unfocus();

                  if (widget.orderMeals.isEmpty) {
                    setState(() => mealsValidation = true);
                    return;
                  }
                  setState(() {
                    mealsValidation = false;
                    payValidation = false;
                    openField = false;
                  });
                  orderCubit.selectPayOption(member: widget.member, index: 2);
                },
                isSelected: orderCubit.selectedPayOption == 2,
              ),
            ],
          ),

          if (mealsValidation)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                context.l10n.chooseMealsValidation,
                style: const TextStyle(
                  color: AppColors.danger,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (payValidation)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                context.l10n.choosePayOptionValidation,
                style: const TextStyle(
                  color: AppColors.danger,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          const SizedBox(height: 10),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Row(
              key: ValueKey(orderCubit.currentIndex > 0),
              children: [
                Expanded(
                  flex: 2,
                  child:
                      orderCubit.currentIndex == orderCubit.members.length - 1
                      ? PrimaryButton(
                          onTap: () => _onNextTap(context),
                          title: context.l10n.order_confirmed,
                          color: AppColors.secondary,
                        )
                      : PrimaryButton(
                          onTap: () => _onNextTap(context),
                          title: context.l10n.next,
                          color: AppColors.primary,
                        ),
                ),
                if (orderCubit.currentIndex > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      onTap: () => context.read<OrderCubit>().previousMember(),
                      title: context.l10n.back,
                      color: AppColors.secondary.withAlpha(50),
                      textColor: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNextTap(BuildContext context) {
    final cubit = context.read<OrderCubit>();
    if (widget.orderMeals.isEmpty || cubit.selectedPayOption == null) {
      setState(() {
        mealsValidation = widget.orderMeals.isEmpty;
        payValidation = widget.member.payOption == null;
      });
      return;
    }
    cubit.nextMember();
  }
}
