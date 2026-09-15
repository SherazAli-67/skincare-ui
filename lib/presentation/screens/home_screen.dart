import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare/constants/string_const.dart';
import 'package:skincare/core/app_colors.dart';
import 'package:skincare/core/app_data.dart';
import 'package:skincare/core/app_icons.dart';
import 'package:skincare/core/app_textstyles.dart';
import 'package:skincare/core/models/category_model.dart';
import 'package:skincare/core/models/product_model.dart';
import 'package:skincare/core/models/promo_banner_model.dart';
import 'package:skincare/presentation/providers/home_provider.dart';
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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _headerAnimation;
  late final Animation<double> _greetingAnimation;
  late final Animation<double> _searchAnimation;
  late final Animation<double> _categoriesAnimation;
  late final Animation<double> _promoAnimation;
  late final Animation<double> _flashHeaderAnimation;
  late final Animation<double> _flashListAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _headerAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.00, 0.22, curve: Curves.easeOutCubic));
    _greetingAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.08, 0.30, curve: Curves.easeOutCubic));
    _searchAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.16, 0.38, curve: Curves.easeOutCubic));
    _categoriesAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.24, 0.46, curve: Curves.easeOutCubic));
    _promoAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.32, 0.58, curve: Curves.easeOutCubic));
    _flashHeaderAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.48, 0.70, curve: Curves.easeOutCubic));
    _flashListAnimation = CurvedAnimation(parent: _entranceController, curve: const Interval(0.55, 0.90, curve: Curves.easeOutCubic));
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
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
              _buildFadeSlideIn(animation: _headerAnimation, child: _buildHeader()),
              _buildFadeSlideIn(animation: _greetingAnimation, child: _buildGreeting()),
              _buildFadeSlideIn(animation: _searchAnimation, child: _buildSearchField()),
              _buildFadeSlideIn(animation: _categoriesAnimation, child: _buildCategories(context)),
              _buildFadeSlideIn(animation: _promoAnimation, child: _buildPromoSection(context)),
              _buildFadeSlideIn(animation: _flashHeaderAnimation, child: _buildFlashSaleHeader()),
              _buildFadeSlideIn(animation: _flashListAnimation, beginOffset: const Offset(0.04, 0), child: _buildFlashSaleList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFadeSlideIn({
    required Animation<double> animation,
    required Widget child,
    Offset beginOffset = const Offset(0, 0.06),
  }) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(begin: beginOffset, end: Offset.zero).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        LogoWithText(),
        CircleIconButton(iconPath: AppIcons.icNotifications),
      ],
    );
  }

  Widget _buildGreeting() {
    final user = AppData.userGreeting;
    return Row(
      spacing: 14,
      children: [
        ClipOval(child: Image.asset(user.avatarPath, width: 48, height: 48, fit: .cover)),
        Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 12,
              children: [
                Text('${StringConst.helloPrefix} ${user.name}!', style: AppTextStyles.titleLarge),
                SvgPicture.asset(AppIcons.icSparkle, width: 13, height: 16),
              ],
            ),
            Text(user.subtitle, style: AppTextStyles.bodyMedium),
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
          Text(StringConst.searchProductHint, style: AppTextStyles.searchHint),
          SvgPicture.asset(AppIcons.icSearch),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: AppData.categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => _buildCategoryChip(context, category: AppData.categories[index], index: index),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, {required CategoryModel category, required int index}) {
    final selected = context.watch<HomeProvider>().selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().selectCategory(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: .symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.chipBackground,
          borderRadius: .circular(9999),
        ),
        child: Text(category.label, style: selected ? AppTextStyles.chipSelected : AppTextStyles.chip),
      ),
    );
  }

  Widget _buildPromoSection(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return AnimatedBuilder(
      animation: provider.pageController,
      builder: (context, _) {
        final page = provider.bannerPage;
        return Column(
          spacing: 10,
          children: [
            SizedBox(
              height: 205,
              child: PageView.builder(
                controller: provider.pageController,
                itemCount: AppData.promoBanners.length,
                onPageChanged: (index) => provider.setBannerIndex(index),
                itemBuilder: (_, index) => _buildPromoBanner(context, banner: AppData.promoBanners[index], pageOffset: page, index: index),
              ),
            ),
            Row(
              spacing: 8,
              mainAxisAlignment: .center,
              children: List.generate(
                AppData.promoBanners.length,
                (dotIndex) => _buildPaginationDot(bannerIndex: page.round(), dotIndex: dotIndex),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPromoBanner(
    BuildContext context, {
    required PromoBannerModel banner,
    required double pageOffset,
    required int index,
  }) {
    final parallax = (pageOffset - index).clamp(-1.0, 1.0);
    return Container(
      margin: .symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: .circular(16)),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: Stack(
          fit: .expand,
          children: [
            Transform.translate(
              offset: Offset(parallax * -28, 0),
              child: Transform.scale(
                scale: 1.12,
                child: Image.asset(
                  banner.imagePath,
                  fit: .cover,
                  alignment: Alignment(-parallax * 0.6, 0),
                ),
              ),
            ),
            Padding(
              padding: .all(20),
              child: Transform.translate(
                offset: Offset(parallax * 12, 0),
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
                          child: Text(banner.tag, style: AppTextStyles.promoTag),
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: .start,
                          children: [
                            Text(banner.titleLine1, style: AppTextStyles.headlineMedium),
                            Text(banner.titleLine2, style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textHeadlineAccent)),
                            Text(banner.subtitle, style: AppTextStyles.bodySmall),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationDot({required int bannerIndex, required int dotIndex}) {
    final active = bannerIndex == dotIndex;
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
        Text(StringConst.flashSale, style: AppTextStyles.titleMedium),
        Text(StringConst.viewMore, style: AppTextStyles.labelSmall),
      ],
    );
  }

  Widget _buildFlashSaleList(BuildContext context) {
    final products = context.watch<HomeProvider>().products;
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, index) => _buildProductCard(context, products[index], index),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product, int index) {
    final begin = (0.55 + index * 0.08).clamp(0.0, 0.85);
    final end = (begin + 0.22).clamp(begin + 0.01, 1.0);
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final t = Interval(begin, end, curve: Curves.easeOutCubic).transform(_entranceController.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(offset: Offset(18 * (1 - t), 0), child: child),
        );
      },
      child: Container(
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
                  child: Image.asset(product.imagePath, height: 130, width: 130, fit: .cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => context.read<HomeProvider>().toggleFavorite(index),
                    child: Container(
                      padding: .all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        shape: .circle,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                        child: product.isFavorite
                            ? Icon(Icons.favorite, key: const ValueKey('fav'), color: AppColors.primary)
                            : SvgPicture.asset(AppIcons.icFavorite, key: const ValueKey('unfav'), height: 20),
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
                      child: Text(product.name, maxLines: 2, overflow: .ellipsis, style: AppTextStyles.productTitle),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.price),
                        RatingLabel(rating: product.rating, reviewCount: product.reviewCount),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
