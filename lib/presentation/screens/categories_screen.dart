import 'package:flutter/material.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_textstyles.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisAlignment: .center,
          children: [
            Text(StringConst.tabCategories, style: AppTextStyles.titleMedium,),
            Text(StringConst.comingSoon, style: AppTextStyles.bodyMedium,),
          ],
        ),
      ),
    );
  }
}
