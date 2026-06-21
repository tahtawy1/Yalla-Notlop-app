import 'package:dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:yalla_notlop_app/core/constants/app_image_assets.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _fadeAnimation;

  late AnimationController _textController;
  late Animation<double> _textFadeAnim;
  late Animation<double> _textSlideAnim;
  @override
  void initState() {
    _setupAnimation();
    Future.delayed(Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      context.go(AppRoutes.home);
    });
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientEnd,
                ],
              ),
            ),
            child: Stack(
              children: [
                _FloatingIconBubble(
                  imagePath: AppImageAssets.feed,
                  size: maxWidth * 0.2,
                  top: maxHeight * 0.15,
                  right: maxWidth * 0.06,
                ),
                _FloatingIconBubble(
                  imagePath: AppImageAssets.burger,
                  size: maxWidth * 0.25,
                  top: maxHeight * 0.32,
                  left: 18,
                ),
                _FloatingIconBubble(
                  imagePath: AppImageAssets.drink,
                  size: maxWidth * 0.15,
                  top: maxHeight * 0.75,
                  right: maxWidth * 0.06,
                ),
                _FloatingIconBubble(
                  imagePath: AppImageAssets.pizza,
                  size: maxWidth * 0.15,
                  top: maxHeight * 0.85,
                  left: maxWidth * 0.06,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: child,
                        );
                      },
                      child: _LogoCircle(size: maxWidth * 0.52),
                    ),
                    SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _textFadeAnim,
                          child: Transform.translate(
                            offset: Offset(0, _textSlideAnim.value),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        context.l10n.splashTitle,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _textFadeAnim,
                          child: Transform.translate(
                            offset: Offset(0, _textSlideAnim.value * 2),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        context.l10n.splashSubtitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: child,
                        );
                      },
                      child: _LoadingIndicator(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _setupAnimation() {
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 650),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _textFadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlideAnim = Tween<double>(
      begin: -20,
      end: 0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _logoController.forward().then((_) {
      _textController.forward();
    });
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: LinearProgressIndicator(
        backgroundColor: AppColors.secondary.withAlpha(52),
        color: AppColors.primary,
        minHeight: 8,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _LogoCircle extends StatelessWidget {
  const _LogoCircle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(size * 0.08),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: DashedBorder(
                  color: AppColors.dashedBorder,
                  width: 2.5,
                ),
              ),
              padding: EdgeInsets.all(size * 0.1),
              child: Image.asset(AppImageAssets.logo),
            ),
          ),
          Positioned(
            bottom: size * 0.06,
            right: size * 0.04,
            child: _CartBadge(badgeSize: size * 0.22),
          ),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  const _CartBadge({required this.badgeSize});

  final double badgeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: const BoxDecoration(
        color: AppColors.badge,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.shopping_cart_checkout,
        color: AppColors.surface,
        size: badgeSize * 0.55,
      ),
    );
  }
}

class _FloatingIconBubble extends StatelessWidget {
  const _FloatingIconBubble({
    required this.imagePath,
    required this.size,
    this.top,
    this.left,
    this.right,
  });

  final String imagePath;
  final double size;
  final double? top;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.iconCircle,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(size * 0.22),
        child: Image.asset(imagePath),
      ),
    );
  }
}
