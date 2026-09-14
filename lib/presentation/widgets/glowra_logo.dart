import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare/core/app_icons.dart';

class GlowraLogo extends StatelessWidget {
  final double height;
  final double width;

  const GlowraLogo({
    super.key,
    this.height = 30,
    this.width = 99,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppIcons.logoWithText, height: height, width: width,);
  }
}
