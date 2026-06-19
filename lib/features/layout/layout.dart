import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/services/service_locator.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/member/members_view.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/member_cubit/member_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/home_view.dart';
import 'package:yalla_notlop_app/features/home/presentation/view/widgets/floating_action_button.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;
  final pages = [HomeView(), TestFriendsPage(), TestHistoryPage()];
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
      floatingActionButton: currentIndex == 0 ? FAButton() : null,
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

class TestHistoryPage extends StatelessWidget {
  const TestHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.l10n.history, style: TextStyle(fontSize: 32)),
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
