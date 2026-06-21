import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/confirm_dialog.dart';
import 'package:yalla_notlop_app/shared/widgets/app_logo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Application Section
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Center(child: AppLogo()),
                  // const SizedBox(height: 16),
                  Text(
                    context.l10n.appName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.splashSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Language Section
            ListTile(
              leading: const Icon(
                Icons.language_rounded,
                color: AppColors.primary,
              ),
              title: Text(
                context.l10n.changeLanguage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                context.read<LocalizationCubit>().changeLang();
              },
            ),

            // About Us Section
            const Divider(color: AppColors.border, indent: 24, endIndent: 24),
            ListTile(
              leading: const Icon(Icons.info_rounded, color: AppColors.primary),
              title: Text(
                context.l10n.aboutUs,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close Drawer
                context.push(AppRoutes.aboutUs);
              },
            ),

            const Spacer(),

            // Exit Application
            const Divider(color: AppColors.border),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app_rounded,
                color: AppColors.danger,
              ),
              title: Text(
                context.l10n.exitApp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.danger,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close Drawer
                ConfirmDialog.show(
                  context,
                  title: context.l10n.exitApp,
                  message: context.l10n.exitAppMessage,
                  confirmText: context.l10n.confirmExit,
                  cancelText: context.l10n.cancel,
                  confirmColor: AppColors.danger,
                  onConfirm: () {
                    SystemNavigator.pop();
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
