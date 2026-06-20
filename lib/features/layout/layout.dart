import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';

import 'package:yalla_notlop_app/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/home_view.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/floating_action_button.dart';
import 'package:yalla_notlop_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/manage_categories/views/manage_categories_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/history/order_history_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_history_cubit/order_history_cubit.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;
  final pages = [
    HomeView(),
    ManageCategoriesView(),
    BlocProvider(
      create: (_) => getIt<OrderHistoryCubit>()..loadHistory(),
      child: const OrderHistoryView(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            tileMode: TileMode.repeated,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black],
            stops: [0.0, 0.15],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: pages[currentIndex],
      ),
      floatingActionButton: currentIndex == 0
          ? FAButton(
              title: context.l10n.orderNow,
              icon: Icons.play_arrow_rounded,
              onTap: () => context.push(AppRoutes.chooseRestaurantView),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: currentIndex,
        onChanged: (int index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}


class TestFriendsPage extends StatelessWidget {
  const TestFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          context.read<LocalizationCubit>().changeLang();
        },
        icon: Icon(Icons.language),
      ),
    );
  }
}
