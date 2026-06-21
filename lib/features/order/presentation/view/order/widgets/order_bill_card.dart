import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';

class OrderBillCard extends StatelessWidget {
  final OrderModel order;
  final List<MemberModel> members;
  final Widget header;
  final OrderCubit cubit;
  final String collectedLabel;
  final String totalLabel;
  final String settledLabel;
  final String owesLabel;
  final String overpaidLabel;
  final String paidLabel;
  final String noOrdersLabel;

  const OrderBillCard({
    super.key,
    required this.order,
    required this.members,
    required this.header,
    required this.cubit,
    required this.collectedLabel,
    required this.totalLabel,
    required this.settledLabel,
    required this.owesLabel,
    required this.overpaidLabel,
    required this.paidLabel,
    required this.noOrdersLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        header,

        // ================= SUMMARY =================
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$collectedLabel ${order.totalPayed}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$totalLabel ${order.totalAmount}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // ================= MEMBERS =================
        ...members.map((member) {
          final diff = cubit.calculateMemberDiff(member);
          final meals = cubit.membersMealsOrder[member.id];
          final bool owes = diff < 0;

          final String statusText = diff == 0
              ? settledLabel
              : owes
              ? '$owesLabel ${diff.abs().toStringAsFixed(0)}'
              : '$overpaidLabel ${diff.toStringAsFixed(0)}';

          final Color statusColor = diff == 0
              ? AppColors.success
              : owes
              ? AppColors.danger
              : AppColors.success;

          return Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: owes ? Colors.red.shade200 : Colors.green.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── اسم العضو + الحالة ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // ── المبلغ المدفوع ──
                Text(
                  '$paidLabel: ${member.payedAmount}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),

                // ── الوجبات ──
                if (meals != null && meals.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    children: meals.entries.map((e) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.iconBackground,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${e.value}×${e.key.name}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ] else
                  Text(
                    noOrdersLabel,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
              ],
            ),
          );
        }),

        const SizedBox(height: 4),
      ],
    );
  }
}
