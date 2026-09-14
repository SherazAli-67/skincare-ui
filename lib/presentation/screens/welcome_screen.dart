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
import 'package:skincare/presentation/widgets/glowra_logo.dart';
import 'package:skincare/presentation/widgets/primary_button.dart';
import 'package:skincare/router/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              imageFilter: ImageFilter.blur(
                sigmaX: 14,
                sigmaY: 14,
              ),
              child: Container(
              height: 176,
              color: AppColors.featureBlur,),
            )),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 18,
                children: [
                  const GlowraLogo(),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      _buildHeadline(),
                      Text(StringConst.welcomeSubtitle, style: AppTextStyles.bodyMedium,),
                    ],
                  ),
                  const Spacer(),
                  _buildFeatureCard(context),
                ],
              ),
            ),
          ),
        ],
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
      child: SvgPicture.asset(AppIcons.icLeafDecor, width: 140, height: 180,),
    );
  }

  Widget _buildHeroImage() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 100,
      child: Image.asset(AppIcons.imgWelcomeHero, alignment: .bottomCenter,),
    );
  }

  Widget _buildHeadline() {
    return Stack(
      clipBehavior: .none,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(StringConst.welcomeHeadlineLine1, style: AppTextStyles.headlineLarge,),
            Text(
              StringConst.welcomeHeadlineLine2,
              style: AppTextStyles.headlineLarge.copyWith(color: AppColors.textHeadlineAccent),
            ),
          ],
        ),
        Positioned(
          right: 10,
          top: 10,
          child: SvgPicture.asset(AppIcons.icSparkle, width: 22, height: 26,),
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
          PrimaryButton(
            label: StringConst.discoverProducts,
            width: double.infinity,
            onTap: () => context.go(NamedRoutes.home.routeName),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(FeatureItemModel feature) {
    return  Column(
      spacing: 8,
      children: [
        SvgPicture.asset(feature.iconPath,),
        Text(
          feature.title,
          textAlign: .center,
          style: AppTextStyles.labelSmall,
        ),
      ],
    );
  }
}
