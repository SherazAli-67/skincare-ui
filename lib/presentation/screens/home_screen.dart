import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_data.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';
import 'package:skincare/core/models/category_model.dart';
import 'package:skincare/core/models/product_model.dart';
import 'package:skincare/core/models/promo_banner_model.dart';
import 'package:skincare/presentation/widgets/circle_icon_button.dart';
import 'package:skincare/presentation/widgets/glowra_logo.dart';
import 'package:skincare/presentation/widgets/primary_button.dart';
import 'package:skincare/presentation/widgets/rating_label.dart';
import 'package:skincare/router/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _bannerIndex = 0;
  late List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    _products = List.of(AppData.flashSaleProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .fromLTRB(20, 12, 20, 24),
          child: Column(
            spacing: 14,
            crossAxisAlignment: .start,
            children: [
              _buildHeader(),
              _buildGreeting(),
              _buildSearchField(),
              _buildCategories(),
              _buildPromoSection(),
              _buildFlashSaleHeader(),
              _buildFlashSaleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        const GlowraLogo(),
        CircleIconButton(iconPath: AppIcons.icNotifications,),
      ],
    );
  }

  Widget _buildGreeting() {
    final user = AppData.userGreeting;
    return Row(
      spacing: 14,
      children: [
        ClipOval(
          child: Image.asset(user.avatarPath, width: 48, height: 48, fit: .cover,),
        ),
        Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 12,
              children: [
                Text('${StringConst.helloPrefix} ${user.name}!', style: AppTextStyles.titleLarge,),
                SvgPicture.asset(AppIcons.icSparkle, width: 13, height: 16,),
              ],
            ),
            Text(user.subtitle, style: AppTextStyles.bodyMedium,),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: .symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(12),
        border: .all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF887AA6).withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(StringConst.searchProductHint, style: AppTextStyles.searchHint,),
          SvgPicture.asset(AppIcons.icSearch, width: 24, height: 24,),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: AppData.categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => _buildCategoryChip(AppData.categories[index], index),
      ),
    );
  }

  Widget _buildCategoryChip(CategoryModel category, int index) {
    final selected = _selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategoryIndex = index),
      child: Container(
        padding: .symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.chipBackground,
          borderRadius: .circular(9999),
        ),
        child: Text(category.label, style: selected ? AppTextStyles.chipSelected : AppTextStyles.chip,),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          height: 205,
          child: PageView.builder(
            itemCount: AppData.promoBanners.length,
            onPageChanged: (index) => setState(() => _bannerIndex = index),
            itemBuilder: (_, index) => _buildPromoBanner(AppData.promoBanners[index]),
          ),
        ),
        Row(
          spacing: 8,
          mainAxisAlignment: .center,
          children: List.generate(AppData.promoBanners.length, _buildPaginationDot),
        ),
      ],
    );
  }

  Widget _buildPromoBanner(PromoBannerModel banner) {
    return Container(
      margin: .symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
      ),
      child: Stack(
        fit: .expand,
        children: [
          ClipRRect(
            borderRadius: .circular(16),
            child:  Image.asset(banner.imagePath, fit: .cover,),
          ),
          Padding(
            padding: .all(20),
            child: Column(
              spacing: 10,
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: .symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.promoTag,
                        borderRadius: .circular(70),
                        border: .all(color: AppColors.promoTagBorder, width: 0.5),
                      ),
                      child: Text(banner.tag, style: AppTextStyles.promoTag,),
                    ),
                    Column(
                      spacing: 8,
                      crossAxisAlignment: .start,
                      children: [
                        Text(banner.titleLine1, style: AppTextStyles.headlineMedium,),
                        Text(
                          banner.titleLine2,
                          style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textHeadlineAccent),
                        ),
                        Text(banner.subtitle, style: AppTextStyles.bodySmall,),
                      ],
                    ),
                  ],
                ),
                PrimaryButton(
                  label: StringConst.shopNow,
                  width: 112,
                  height: 34,
                  borderRadius: 12,
                  arrowSize: 12,
                  textStyle: AppTextStyles.buttonSmall,
                  onTap: () => context.push(NamedRoutes.skinAnalysis.routeName),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationDot(int index) {
    final active = _bannerIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.paginationInactive.withValues(alpha: 0.2),
        borderRadius: .circular(8),
      ),
    );
  }

  Widget _buildFlashSaleHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(StringConst.flashSale, style: AppTextStyles.titleMedium,),
        Text(StringConst.viewMore, style: AppTextStyles.labelSmall,),
      ],
    );
  }

  Widget _buildFlashSaleList() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: _products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, index) => _buildProductCard(_products[index], index),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product, int index) {
    return Container(
      width: 130,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [AppColors.white, AppColors.productCardEnd],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowPromo.withValues(alpha: 0.27),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(product.imagePath, width: 130, height: 130, fit: .cover,),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() {
                    _products[index] = product.copyWith(isFavorite: !product.isFavorite);
                  }),
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: .all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      shape: .circle,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.icFavorite,
                      colorFilter: .mode(
                        product.isFavorite ? AppColors.primary : AppColors.textSecondary,
                        .srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: .all(8),
              child: Column(
                spacing: 4,
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: AppTextStyles.productTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.price,),
                      RatingLabel(rating: product.rating, reviewCount: product.reviewCount,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
