import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/pass_phone_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/pass_phone/widgets/pay_button.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/primary_button.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
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
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              S.of(context).totalYourOrder,
              style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
            ),
          ),
          SizedBox(height: 8),
          if (widget.orderMeals.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView(
                children: widget.orderMeals.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${e.value} × ${e.key.name}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.splashTitleColor,
                          ),
                        ),
                        Text(
                          '${double.parse(e.key.price) * e.value} ${S.of(context).mealPriceSuffix}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            children: [
              PayButton(
                title: S.of(context).payFullCostBtnTitle,
                onTap: () {
                  if (widget.orderMeals.isEmpty) {
                    setState(() {
                      mealsValidation = true;
                    });
                    return;
                  }
                  setState(() {
                    mealsValidation = false;
                    payValidation = false;
                    openField = false;
                  });
                  orderCubit.selectPayOption(member: widget.member, index: 0);
                },
                isSelected: orderCubit.selectedPayOption == 0,
              ),
              !openField
                  ? PayButton(
                      title: S.of(context).payCustomCostBtnTitle,
                      onTap: () {
                        if (widget.orderMeals.isEmpty) {
                          setState(() {
                            mealsValidation = true;
                          });
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
                            if (widget.orderMeals.isEmpty) {
                              setState(() {
                                mealsValidation = true;
                              });
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
                            setState(() {
                              customBtnSelected = true;
                            });
                            if (mounted) {
                              Future.delayed(Duration(milliseconds: 1000), () {
                                customBtnSelected = false;
                                setState(() {});
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: customBtnSelected
                                  ? AppColors.primaryColor.withAlpha(50)
                                  : AppColors.primaryColor,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
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
                title: S.of(context).payZeroCostBtnTitle,
                onTap: () {
                  if (widget.orderMeals.isEmpty) {
                    setState(() {
                      mealsValidation = true;
                    });
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                S.of(context).chooseMealsValidation,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (payValidation)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                S.of(context).choosePayOptionValidation,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Row(
              key: ValueKey(context.read<OrderCubit>().currentIndex > 0),
              children: [
                Expanded(
                  flex: 2,
                  child:
                      context.read<OrderCubit>().currentIndex ==
                          context.read<OrderCubit>().members.length - 1
                      ? PrimaryButton(
                          onTap: () {
                            if (widget.orderMeals.isEmpty ||
                                context.read<OrderCubit>().selectedPayOption ==
                                    null) {
                              setState(() {
                                if (widget.orderMeals.isEmpty) {
                                  mealsValidation = true;
                                } else {
                                  mealsValidation = false;
                                }
                                if (widget.member.payOption == null) {
                                  log(widget.member.payOption.toString());
                                  payValidation = true;
                                } else {
                                  payValidation = false;
                                }
                              });
                              return;
                            }
                            context.read<OrderCubit>().nextMember();
                          },
                          title: S.of(context).order_confirmed,
                          color: AppColors.secondaryColor,
                        )
                      : PrimaryButton(
                          onTap: () {
                            if (widget.orderMeals.isEmpty ||
                                context.read<OrderCubit>().selectedPayOption ==
                                    null) {
                              setState(() {
                                if (widget.orderMeals.isEmpty) {
                                  mealsValidation = true;
                                } else {
                                  mealsValidation = false;
                                }
                                if (widget.member.payOption == null) {
                                  payValidation = true;
                                } else {
                                  payValidation = false;
                                }
                              });
                              return;
                            }
                            context.read<OrderCubit>().nextMember();
                          },
                          title: S.of(context).next,
                          color: AppColors.primaryColor,
                        ),
                ),
                if (context.read<OrderCubit>().currentIndex > 0) ...[
                  SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      onTap: () {
                        context.read<OrderCubit>().previousMember();
                      },
                      title: S.of(context).back,
                      color: AppColors.secondaryColor.withAlpha(50),
                      textColor: AppColors.primaryColor,
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
}
