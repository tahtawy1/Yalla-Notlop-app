import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/member/widgets/member_manage_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_name_dialog.dart';

class MembersList extends StatelessWidget {
  const MembersList({super.key, required this.members});

  final List<MemberModel> members;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: members.length,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          return MemberManageCard(
            member: members[index],
            onEditTap: () {
              final cubit = context.read<MemberCubit>();
              showDialog(
                context: context,
                builder: (context) => EditNameDialog(
                  initialName: members[index].name,
                  onSaveName: (String name) {
                    cubit.updateMember(name, members[index]);
                  },
                ),
              );
            },
            onDeleteTap: () async {
              final cubit = context.read<MemberCubit>();
              await cubit.deleteMember(members[index]);
            },
            isLastIndex: index == members.length - 1,
          );
        },
      ),
    );
  }
}
