import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';

class RatingLabel extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double iconSize;
  final TextStyle? textStyle;

  const RatingLabel({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.iconSize = 13.24,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      mainAxisSize: .min,
      children: [
        SvgPicture.asset(AppIcons.icRatingStar, width: iconSize, height: iconSize,),
        Text('$rating ($reviewCount)', style: textStyle ?? AppTextStyles.rating,),
      ],
    );
  }
}
