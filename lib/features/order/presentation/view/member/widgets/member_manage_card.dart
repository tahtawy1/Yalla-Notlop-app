import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';

class MemberManageCard extends StatelessWidget {
  const MemberManageCard({
    super.key,
    required this.member,
    required this.onEditTap,
    required this.onDeleteTap,
    this.isLastIndex = false,
  });
  final MemberModel member;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final bool isLastIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLastIndex ? 82 : 0),
      alignment: Alignment.center,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          member.name,
          style: TextStyle(
            color: AppColors.splashTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Image.asset(AppImageAssets.profileIcon),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEditTap,
              icon: Icon(Icons.edit, color: AppColors.splashCartBadge),
            ),
            IconButton(
              onPressed: onDeleteTap,
              icon: Icon(Icons.delete, color: AppColors.dangerColor),
            ),
          ],
        ),
      ),
    );
  }
}
