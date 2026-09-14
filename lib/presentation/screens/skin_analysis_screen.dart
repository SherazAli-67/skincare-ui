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

class SkinAnalysisScreen extends StatelessWidget {
  const SkinAnalysisScreen({super.key});

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
            child: Column(
              children: [
                _buildFaceSection(context, size),
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 14,
                    sigmaY: 14,
                  ),
                  child: Container(
                    height: 176,
                    color: AppColors.background,),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildSuggestPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildFaceSection(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * 0.62,
      child: Stack(
        fit: .expand,
        children: [
          Image.asset(AppIcons.imgSkinAnalysis, fit: .cover, width: double.infinity,),
          _buildScanMarkers(),
          Positioned(
            left: 20,
            right: 20,
            top: 12,
            child: SafeArea(
              child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CircleIconButton(
                  iconPath: AppIcons.icArrowBack,
                  onTap: () => context.pop(),
                ),
                CircleIconButton(iconPath: AppIcons.icShare,),
              ],
                      ),
            ),),
          Positioned(
            bottom: 10,
            left: 12,
            right: 12,
            child:  _buildSkinHealthCard(),),
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
              child: SvgPicture.asset(AppIcons.icScanMarkerLg, width: 28, height: 28,),
            ),
            Positioned(
              left: w * 0.215,
              top: h * 0.60,
              child: SvgPicture.asset(AppIcons.icScanMarkerSm, width: 12, height: 12,),
            ),
            Positioned(
              left: w * 0.557,
              top: h * 0.664,
              child: SvgPicture.asset(AppIcons.icScanMarkerLg, width: 32, height: 32,),
            ),
            Positioned(
              left: w * 0.58,
              top: h * 0.68,
              child: SvgPicture.asset(AppIcons.icScanMarkerSm, width: 14, height: 14,),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSkinHealthCard() {
    final percent = AppData.skinHealthPercent / 100;
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
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: .w600,
                        fontSize: 18,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      '${AppData.skinHealthPercent}%',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: .w600,
                        fontSize: 18,
                        color: AppColors.skinHealthPercent,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(AppIcons.icChevronDown, width: 24, height: 24, colorFilter: .mode(AppColors.white, .srcIn),),
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
                    FractionallySizedBox(
                      widthFactor: percent,
                      child: Container(color: AppColors.progressFill),
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
              Text(
                '${StringConst.suggestProduct} (${products.length})',
                style: AppTextStyles.titleMedium,
              ),
              Divider(height: 1, color: AppColors.suggestBorder,),
              for (var i = 0; i < products.length; i++) ...[
                if (i > 0) Divider(height: 1, color: AppColors.suggestBorder,),
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
          child: Image.asset(product.imagePath, width: 82, height: 82, fit: .cover,),
        ),
        Expanded(
          child: Column(
            spacing: 7,
            crossAxisAlignment: .start,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: .ellipsis,
                style: AppTextStyles.bodyLarge,
              ),
              Row(
                spacing: 4,
                children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
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
        SvgPicture.asset(AppIcons.icAdd, width: 32, height: 32,),
      ],
    );
  }
}
