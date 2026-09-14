import 'package:flutter/material.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.primaryLight,
          surface: AppColors.background,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: StringConst.appFontFamily, fontWeight: .w600, color: AppColors.textHeadline),
          bodyMedium: TextStyle(fontFamily: StringConst.appFontFamily, fontWeight: .w400, color: AppColors.textSecondary),
        ),
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
