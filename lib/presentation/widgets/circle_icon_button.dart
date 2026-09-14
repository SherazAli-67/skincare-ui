import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare/core/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color? iconColor;

  const CircleIconButton({
    super.key,
    required this.iconPath,
    this.onTap,
    this.size = 40,
    this.iconSize = 24,
    this.backgroundColor = AppColors.circleButton,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: .all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: .circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          width: iconSize,
          height: iconSize,
          colorFilter: iconColor == null ? null : .mode(iconColor!, .srcIn),
        ),
      ),
    );
  }
}
