import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final double borderRadius;
  final bool showArrow;
  final TextStyle? textStyle;
  final double arrowSize;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.width,
    this.height = 58,
    this.borderRadius = 18,
    this.showArrow = true,
    this.textStyle,
    this.arrowSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: .circular(borderRadius),
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
        child: Row(
          spacing: 4,
          mainAxisAlignment: .center,
          mainAxisSize: width == null ? .min : .max,
          children: [
            Text(label, style: textStyle ?? AppTextStyles.labelLarge,),
            if (showArrow)
              SvgPicture.asset(
                AppIcons.icArrowNext,
                width: arrowSize,
                height: arrowSize,
                colorFilter: .mode(AppColors.white, .srcIn),
              ),
          ],
        ),
      ),
    );
  }
}
