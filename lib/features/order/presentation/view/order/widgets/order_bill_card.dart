import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class OrderBillCard extends StatelessWidget {
  final OrderModel order;
  final List<MemberModel> members;
  final Widget header;
  final OrderCubit cubit;
  const OrderBillCard({
    super.key,
    required this.order,
    required this.members,
    required this.header,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        ...members.map((member) {
          final double memberCost = cubit.calculateMemberCost(member);
          final double diff = cubit.calculateMemberDiff(member);
          final meals = cubit.membersMealsOrder[member.id];

          // ── Status derivation ─────────────────────────────────────────────────
          final String statusText;
          final Color statusColor;
          final Widget? badge;
          final bool isPayer;
          final bool owes;

          if (diff == 0 && memberCost >= 0) {
            statusText = S.current.settled;
            statusColor = Colors.green.shade700;
            badge = const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            );
            isPayer = false;
            owes = false;
          } else if (diff < 0) {
            statusText =
                '${S.current.owes} ${diff.abs().toStringAsFixed(0)} ${S.current.mealPriceSuffix}';
            statusColor = AppColors.dangerColor;
            badge = const Icon(
              Icons.error,
              color: AppColors.dangerColor,
              size: 16,
            );
            isPayer = false;
            owes = true;
          } else {
            statusText =
                '${S.current.overpaid} ${diff.toStringAsFixed(0)} ${S.current.mealPriceSuffix}';
            statusColor = Colors.green.shade700;
            badge = null;
            isPayer = true;
            owes = false;
          }

          // ── Card colours ──────────────────────────────────────────────────────
          final Color cardBackground = isPayer
              ? Colors.green.shade50
              : owes
              ? AppColors.dangerBackground
              : Colors.white;

          final Color borderColor = isPayer
              ? Colors.green.shade200
              : owes
              ? Colors.red.shade200
              : Colors.black45;

          // ── Card ──────────────────────────────────────────────────────────────
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: borderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Member header ─────────────────────────────────────────
                    Row(
                      children: [
                        // Avatar with optional badge
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 40, // radius 20 × 2
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.restaurantIconBg,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(member.name[0]),
                            ),
                            if (badge != null)
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: badge,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Name + status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.splashTitleColor,
                                ),
                              ),
                              Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Divider(height: 1, thickness: 1),
                    const SizedBox(height: 12),

                    // ── Meal rows ─────────────────────────────────────────────
                    if (meals != null && meals.isNotEmpty)
                      ...meals.entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${e.value} × ${e.key.name}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.splashTitleColor,
                                ),
                              ),
                              Text(
                                '${double.parse(e.key.price) * e.value}'
                                ' ${S.current.mealPriceSuffix}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: Text(
                          S.current.no_orders,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.splashTitleColor,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    // ── Paid amount row ───────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'دفع: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.splashTitleColor,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${member.payedAmount} ${S.current.mealPriceSuffix}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryColor,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.collected,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${order.totalPayed.toStringAsFixed(0)} ${S.current.mealPriceSuffix}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        S.current.total,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${order.totalAmount.toStringAsFixed(0)} ${S.current.mealPriceSuffix}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: AppColors.splashTitleColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
