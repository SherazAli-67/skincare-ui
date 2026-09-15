import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_data.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';
import 'package:skincare/core/models/product_model.dart';
import 'package:skincare/presentation/widgets/circle_icon_button.dart';
import 'package:skincare/presentation/widgets/rating_label.dart';

class SkinAnalysisScreen extends StatefulWidget {
  const SkinAnalysisScreen({super.key});

  @override
  State<SkinAnalysisScreen> createState() => _SkinAnalysisScreenState();
}

class _SkinAnalysisScreenState extends State<SkinAnalysisScreen> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _scanController;
  late final Animation<double> _faceAnimation;
  late final Animation<double> _topBarAnimation;
  late final Animation<double> _healthCardAnimation;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _panelAnimation;
  late final Animation<double> _markerPulseA;
  late final Animation<double> _markerPulseB;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scanController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _faceAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.00, 0.35, curve: Curves.easeOutCubic));
    _topBarAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.00, 0.25, curve: Curves.easeOutCubic));
    _healthCardAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.25, 0.60, curve: Curves.easeOutCubic));
    _progressAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.40, 0.85, curve: Curves.easeOutCubic));
    _panelAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.45, 0.90, curve: Curves.easeOutCubic));
    _markerPulseA = Tween(begin: 0.82, end: 1.0).animate(CurvedAnimation(parent: _scanController, curve: Curves.easeInOut));
    _markerPulseB = Tween(begin: 1.0, end: 0.82).animate(CurvedAnimation(parent: _scanController, curve: Curves.easeInOut));
    _entranceController.forward();
    _scanController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(children: [_buildFaceSection(context, size)]),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 175,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(height: 176, color: AppColors.background),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: _buildFadeSlideIn(
              animation: _panelAnimation,
              beginOffset: const Offset(0, 0.12),
              child: _buildSuggestPanel(),
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

  Widget _buildFaceSection(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.62,
      child: Stack(
        fit: .expand,
        children: [
          FadeTransition(
            opacity: _faceAnimation,
            child: Image.asset(AppIcons.imgSkinAnalysis, fit: .cover, width: double.infinity),
          ),
          _buildScanMarkers(),
          Positioned(
            left: 20,
            right: 20,
            top: 12,
            child: SafeArea(
              child: FadeTransition(
                opacity: _topBarAnimation,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    CircleIconButton(iconPath: AppIcons.icArrowBack, onTap: () => context.pop()),
                    CircleIconButton(iconPath: AppIcons.icShare),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 12,
            right: 12,
            child: _buildFadeSlideIn(
              animation: _healthCardAnimation,
              beginOffset: const Offset(0, 0.08),
              child: _buildSkinHealthCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanMarkers() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          children: [
            Positioned(
              left: w * 0.195,
              top: h * 0.587,
              child: _buildPulsingMarker(animation: _markerPulseA, child: SvgPicture.asset(AppIcons.icScanMarkerLg, width: 28, height: 28)),
            ),
            Positioned(
              left: w * 0.215,
              top: h * 0.60,
              child: _buildPulsingMarker(animation: _markerPulseB, child: SvgPicture.asset(AppIcons.icScanMarkerSm, width: 12, height: 12)),
            ),
            Positioned(
              left: w * 0.557,
              top: h * 0.664,
              child: _buildPulsingMarker(animation: _markerPulseB, child: SvgPicture.asset(AppIcons.icScanMarkerLg, width: 32, height: 32)),
            ),
            Positioned(
              left: w * 0.58,
              top: h * 0.68,
              child: _buildPulsingMarker(animation: _markerPulseA, child: SvgPicture.asset(AppIcons.icScanMarkerSm, width: 14, height: 14)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPulsingMarker({required Animation<double> animation, required Widget child}) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: animation, child: child),
    );
  }

  Widget _buildSkinHealthCard() {
    final targetPercent = AppData.skinHealthPercent / 100;
    return Container(
      height: 72,
      padding: .fromLTRB(20, 14, 16, 16),
      decoration: BoxDecoration(
        borderRadius: .circular(18),
        border: .all(color: AppColors.skinHealthBorder),
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [
            AppColors.primaryLight,
            AppColors.primaryVia,
            AppColors.primaryDark,
          ],
          stops: const [0, 0.5, 1],
        ),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  spacing: 4,
                  children: [
                    Text(
                      StringConst.skinHealth,
                      style: AppTextStyles.titleLarge.copyWith(fontWeight: .w600, fontSize: 18, color: AppColors.white),
                    ),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (_, _) {
                        final value = (_progressAnimation.value * AppData.skinHealthPercent).round();
                        return Text(
                          '$value%',
                          style: AppTextStyles.titleLarge.copyWith(fontWeight: .w600, fontSize: 18, color: AppColors.skinHealthPercent),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(AppIcons.icChevronDown, width: 24, height: 24, colorFilter: .mode(AppColors.white, .srcIn)),
            ],
          ),
          Align(
            alignment: .centerLeft,
            child: SizedBox(
              width: 249,
              height: 6,
              child: ClipRRect(
                borderRadius: .circular(40),
                child: Stack(
                  children: [
                    Container(color: AppColors.progressTrack),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (_, _) => FractionallySizedBox(
                        widthFactor: targetPercent * _progressAnimation.value,
                        child: Container(color: AppColors.progressFill),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestPanel() {
    final products = AppData.suggestedProducts;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: .all(color: AppColors.suggestBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowPromo.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: .fromLTRB(20, 14, 20, 16),
          child: Column(
            spacing: 14,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text('${StringConst.suggestProduct} (${products.length})', style: AppTextStyles.titleMedium),
              Divider(height: 1, color: AppColors.suggestBorder),
              for (var i = 0; i < products.length; i++) ...[
                if (i > 0) Divider(height: 1, color: AppColors.suggestBorder),
                _buildSuggestedProductTile(products[i]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedProductTile(ProductModel product) {
    return Row(
      spacing: 12,
      children: [
        ClipRRect(
          borderRadius: .circular(12),
          child: Image.asset(product.imagePath, width: 82, height: 82, fit: .cover),
        ),
        Expanded(
          child: Column(
            spacing: 7,
            crossAxisAlignment: .start,
            children: [
              Text(product.name, maxLines: 2, overflow: .ellipsis, style: AppTextStyles.bodyLarge),
              Row(
                spacing: 4,
                children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.labelMedium.copyWith(fontSize: 16)),
                  RatingLabel(
                    rating: product.rating,
                    reviewCount: product.reviewCount,
                    iconSize: 16,
                    textStyle: AppTextStyles.rating.copyWith(fontSize: 12, height: 16 / 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        SvgPicture.asset(AppIcons.icAdd, width: 32, height: 32),
      ],
    );
  }
}
