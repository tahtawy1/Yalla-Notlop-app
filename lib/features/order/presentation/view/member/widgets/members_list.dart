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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...members.map(
          (m) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MemberManageCard(
              member: m,
              onEditTap: () {
                final cubit = context.read<MemberCubit>();
                showDialog(
                  context: context,
                  builder: (context) => EditNameDialog(
                    initialName: m.name,
                    onSaveName: (String name) {
                      cubit.updateMember(name, m);
                    },
                  ),
                );
              },
              onDeleteTap: () async {
                final cubit = context.read<MemberCubit>();
                await cubit.deleteMember(m);
              },
              isLastIndex: m.id == members[members.length - 1].id,
            ),
          ),
        ),
      ],
    );
  }
}
