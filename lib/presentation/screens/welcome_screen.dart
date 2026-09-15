import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_data.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';
import 'package:skincare/core/models/feature_item_model.dart';
import 'package:skincare/presentation/widgets/primary_button.dart';
import 'package:skincare/router/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _sparkleController;
  late final Animation<double> _headlineAnimation;
  late final Animation<double> _leafAnimation;
  late final Animation<double> _heroAnimation;
  late final Animation<double> _featureAnimation;
  late final Animation<double> _sparkleScale;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _sparkleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _headlineAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.00, 0.35, curve: Curves.easeOutCubic));
    _leafAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.10, 0.40, curve: Curves.easeOutCubic));
    _heroAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.20, 0.55, curve: Curves.easeOutCubic));
    _featureAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic));
    _sparkleScale = Tween(begin: 1.0, end: 1.12).animate(CurvedAnimation(parent: _sparkleController, curve: Curves.easeInOut));
    _entranceController.forward().then((_) {
      if (mounted) _sparkleController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildLeafDecor(),
          _buildHeroImage(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(height: 176, color: AppColors.featureBlur),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 18,
                children: [
                  _buildFadeSlideIn(
                    animation: _headlineAnimation,
                    beginOffset: const Offset(0, -0.04),
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        _buildHeadline(),
                        Text(StringConst.welcomeSubtitle, style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _buildFadeSlideIn(
                    animation: _featureAnimation,
                    beginOffset: const Offset(0, 0.1),
                    child: _buildFeatureCard(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFadeSlideIn({
    required Animation<double> animation,
    required Widget child,
    Offset beginOffset = const Offset(0, 0.06),
  }) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(begin: beginOffset, end: Offset.zero).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [
            AppColors.backgroundStart,
            AppColors.backgroundMid,
            AppColors.backgroundEnd,
          ],
          stops: const [0, 0.5, 1],
        ),
      ),
    );
  }

  Widget _buildLeafDecor() {
    return Positioned(
      top: 100,
      right: 0,
      child: FadeTransition(
        opacity: _leafAnimation,
        child: ScaleTransition(
          scale: Tween(begin: 0.92, end: 1.0).animate(_leafAnimation),
          alignment: .centerRight,
          child: SvgPicture.asset(AppIcons.icLeafDecor, height: 180, width: 140),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 100,
      child: _buildFadeSlideIn(
        animation: _heroAnimation,
        beginOffset: const Offset(0, 0.08),
        child: Image.asset(AppIcons.imgWelcomeHero, alignment: .bottomCenter),
      ),
    );
  }

  Widget _buildHeadline() {
    return Stack(
      clipBehavior: .none,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(StringConst.welcomeHeadlineLine1, style: AppTextStyles.headlineLarge),
            Text(StringConst.welcomeHeadlineLine2, style: AppTextStyles.headlineLarge.copyWith(color: AppColors.textHeadlineAccent)),
          ],
        ),
        Positioned(
          right: 10,
          top: 10,
          child: ScaleTransition(
            scale: _sparkleScale,
            child: SvgPicture.asset(AppIcons.icSparkle, height: 26, width: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .fromLTRB(16, 17, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.featureCard,
        borderRadius: .circular(20),
        border: .all(color: AppColors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBrown.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              for (final feature in AppData.welcomeFeatures) _buildFeatureItem(feature),
            ],
          ),
          PrimaryButton(label: StringConst.discoverProducts, width: .infinity, onTap: () => context.go(NamedRoutes.home.routeName)),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(FeatureItemModel feature) {
    return Column(
      spacing: 8,
      children: [
        SvgPicture.asset(feature.iconPath),
        Text(feature.title, textAlign: .center, style: AppTextStyles.labelSmall),
      ],
    );
  }
}