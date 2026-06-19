import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/shared/widgets/custom_text_field.dart';

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
                      return context.l10n.memberNameValidation;
                    }
                    return null;
                  },
                  hintText: context.l10n.memberNameHint,
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
