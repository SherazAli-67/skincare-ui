import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';

class MainShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 79,
      decoration: BoxDecoration(
        color: AppColors.bottomNav,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: .all(color: AppColors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowPromo.withValues(alpha: 0.16),
            blurRadius: 6,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      alignment: .center,
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          _buildNavItem(0, AppIcons.icHome, StringConst.tabHome),
          _buildNavItem(1, AppIcons.icCategory, StringConst.tabCategories),
          _buildNavItem(2, AppIcons.icCart, StringConst.tabCart),
          _buildNavItem(3, AppIcons.icProfile, StringConst.tabProfile),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final selected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index),
      behavior: .opaque,
      child: Opacity(
        opacity: selected ? 1 : 0.5,
        child: Column(
          spacing: 6,
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 26,
              height: 26,
              colorFilter: .mode(AppColors.navActive, .srcIn),
            ),
            Text(label, style: AppTextStyles.caption.copyWith(fontWeight: .w500),),
          ],
        ),
      ),
    );
  }
}
