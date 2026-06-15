import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/member/presentation/view_model/cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/restaurant_management/widgets/edit_name_dialog.dart';
import 'package:yalla_notlop_app/shared/widgets/custom_text_field.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/shared/widgets/app_logo.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppLogo()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).membersViewSubTitle,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.splashTitleColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                S.of(context).membersViewDiscription,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.restaurantTextMuted,
                ),
              ),
              SizedBox(height: 36),
              AddMemberForm(),
              SizedBox(height: 26),
              Text(
                S.of(context).members,
                style: TextStyle(
                  color: AppColors.splashTitleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              BlocBuilder<MemberCubit, MemberState>(
                buildWhen: (previous, current) =>
                    current is GetMembersLoading ||
                    current is GetMembersSuccess ||
                    current is GetMembersFailure,
                builder: (BuildContext context, MemberState state) {
                  if (state is MemberInitial || state is GetMembersLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is GetMembersFailure) {
                    return Center(child: Text(state.errMessage));
                  }
                  if (state is GetMembersSuccess) {
                    if (state.members.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            S.of(context).noMembers,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.splashTitleColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return MembersList(members: state.members);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          );
        },
      ),
    );
  }
}

class AddMemberForm extends StatefulWidget {
  const AddMemberForm({super.key});
  @override
  State<AddMemberForm> createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: nameController,
                  autovalidateMode: autovalidateMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).memberNameValidation;
                    }
                    return null;
                  },
                  hintText: S.of(context).memberNameHint,
                  radius: 32,
                  hintColor: AppColors.restaurantFieldFillColor,
                  fillColor: AppColors.splashGradientEnd,
                  enabledBorderColor: AppColors.splashGradientEnd,
                  focusedBorderColor: AppColors.restaurantFieldBorder,
                ),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<MemberCubit>().addMember(
                      MemberModel.create(name: nameController.text.trim()),
                    );
                    nameController.clear();
                    autovalidateMode = AutovalidateMode.disabled;
                    setState(() {});
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.restaurantBackground,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MemberManageCard extends StatelessWidget {
  const MemberManageCard({
    super.key,
    required this.member,
    required this.onEditTap,
    required this.onDeleteTap,
  });
  final MemberModel member;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
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
