import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/utils/app_snack_bar.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/member/widgets/add_member_form.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/member/widgets/members_list.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/primary_button.dart';
import 'package:yalla_notlop_app/shared/widgets/app_logo.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  late final OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = getIt<OrderCubit>();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: AppLogo()),
      bottomNavigationBar: BlocListener<MemberCubit, MemberState>(
        listener: (context, state) {
          if (state is ReadyToStart) {
            _orderCubit.getMembers(state.members);
            context.push(
              AppRoutes.passPhoneView,
              extra: {
                'members': state.members,
                'restaurant': widget.restaurant,
                'orderCubit': _orderCubit,
              },
            );
          }
          if (state is NotEnoughMembers) {
            AppSnackBar.showSnackBar(
              context,
              state.message,
              SnackBarType.error,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
            child: SizedBox(
              height: 52,
              width: double.infinity,
              child: PrimaryButton(
                onTap: () {
                  context.read<MemberCubit>().checkButtonState(context);
                },
                title: context.l10n.passButtonTitle,
                prefixIcon: Icons.cell_tower_outlined,
                color: AppColors.primary,
                radius: 32,
                fontSize: 18,
                iconSize: 24,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.membersViewSubTitle,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.membersViewDiscription,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 36),
              const AddMemberForm(),
              const SizedBox(height: 26),
              Text(
                context.l10n.members,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<MemberCubit, MemberState>(
                  buildWhen: (previous, current) =>
                      current is GetMembersLoading ||
                      current is GetMembersSuccess ||
                      current is GetMembersFailure,
                  builder: (BuildContext context, MemberState state) {
                    if (state is MemberInitial || state is GetMembersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetMembersFailure) {
                      return Center(child: Text(state.errMessage));
                    }
                    if (state is GetMembersSuccess) {
                      if (state.members.isEmpty) {
                        return Center(
                          child: Text(
                            context.l10n.noMembers,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: MembersList(members: state.members),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
