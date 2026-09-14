import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/models/category_model.dart';
import 'package:skincare/core/models/feature_item_model.dart';
import 'package:skincare/core/models/product_model.dart';
import 'package:skincare/core/models/promo_banner_model.dart';
import 'package:skincare/core/models/user_greeting_model.dart';

class AppData {
  static const userGreeting = UserGreetingModel(
    name: StringConst.userName,
    subtitle: StringConst.homeGreetingSubtitle,
    avatarPath: AppIcons.imgAvatar,
  );

  static const skinHealthPercent = 80;

  static const welcomeFeatures = [
    FeatureItemModel(iconPath: AppIcons.icNaturalIngredients, title: StringConst.naturalIngredients),
    FeatureItemModel(iconPath: AppIcons.icDeepHydration, title: StringConst.deepHydration),
    FeatureItemModel(iconPath: AppIcons.icHealthyGlow, title: StringConst.healthyGlow),
  ];

  static const categories = [
    CategoryModel(id: 'all', label: StringConst.categoryAll),
    CategoryModel(id: 'skincare', label: StringConst.categorySkincare),
    CategoryModel(id: 'sunscreen', label: StringConst.categorySunscreen),
    CategoryModel(id: 'body_lotion', label: StringConst.categoryBodyLotion),
    CategoryModel(id: 'makeup', label: StringConst.categoryMakeup),
  ];

  static const promoBanners = [
    PromoBannerModel(
      tag: StringConst.newArrival,
      titleLine1: StringConst.promoTitleLine1,
      titleLine2: StringConst.promoTitleLine2,
      subtitle: StringConst.promoSubtitle,
      imagePath: AppIcons.imgPromoBanner,
    ),
    PromoBannerModel(
      tag: StringConst.newArrival,
      titleLine1: StringConst.promoTitleLine1,
      titleLine2: StringConst.promoTitleLine2,
      subtitle: StringConst.promoSubtitle,
      imagePath: AppIcons.imgPromoBanner,
    ),
    PromoBannerModel(
      tag: StringConst.newArrival,
      titleLine1: StringConst.promoTitleLine1,
      titleLine2: StringConst.promoTitleLine2,
      subtitle: StringConst.promoSubtitle,
      imagePath: AppIcons.imgPromoBanner,
    ),
  ];

  static const flashSaleProducts = [
    ProductModel(
      id: 'serum',
      name: 'Radiance Serum with Vitamin C',
      price: 24.28,
      rating: 4.8,
      reviewCount: 129,
      imagePath: AppIcons.imgProductSerum,
      isFavorite: true,
    ),
    ProductModel(
      id: 'lotion',
      name: 'Skincare Keratin with flower lotion',
      price: 52.88,
      rating: 4.8,
      reviewCount: 86,
      imagePath: AppIcons.imgProductLotion,
      isFavorite: true,
    ),
    ProductModel(
      id: 'sunscreen',
      name: 'Sun Shield SPF 50 Sunscreen',
      price: 18.40,
      rating: 4.8,
      reviewCount: 129,
      imagePath: AppIcons.imgProductSunscreen,
    ),
  ];

  static const suggestedProducts = [
    ProductModel(
      id: 'suggest_serum',
      name: 'Radiance Serum with Vitamin C',
      price: 24.28,
      rating: 4.8,
      reviewCount: 129,
      imagePath: AppIcons.imgSuggestSerum,
    ),
    ProductModel(
      id: 'suggest_lotion',
      name: 'Skincare Keratin with flower lotion',
      price: 52.88,
      rating: 4.8,
      reviewCount: 86,
      imagePath: AppIcons.imgSuggestLotion,
    ),
  ];
}
