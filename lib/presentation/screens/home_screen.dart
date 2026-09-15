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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              //header,
              //greeting,
              //searchField
              //categories
              //promoSection
              //flashSaleHeader
              //flashSaleList
              _buildFlashSaleList(context),
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
        //logoWithText
        //circleIconButton
      ],
    );
  }

  Widget _buildGreeting() {
    final user = AppData.userGreeting;
    return Row(
      spacing: 14,
      children: [
        // ClipOval(
        //   child: Image.asset(user.avatarPath, width: 48, height: 48, fit: .cover,),
        // ),
        Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 12,
              children: [
                //${StringConst.helloPrefix} ${user.name}!, titleLarge
                //icSparkle, width: 13, height: 16
              ],
            ),
            //user.subtitle, bodyMedium
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: .symmetric(horizontal: 16, vertical: 10),
     /* decoration: BoxDecoration(
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
      ),*/
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          //searchProductHint, searchHint
          //icSearch
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
        // _buildCategoryChip
        itemBuilder: (_, index) => const SizedBox()
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, {required CategoryModel category, required int index}) {
    final selected = context.watch<HomeProvider>().selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().selectCategory(index),
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

                //pageOffset: page
                itemBuilder: (_, index) => const SizedBox()
              ),
            ),
            Row(
              spacing: 8,
              mainAxisAlignment: .center,
              children: List.generate(
                AppData.promoBanners.length,
                //bannerIndex: page.round(),
                (dotIndex) => const SizedBox()
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
      decoration: BoxDecoration(borderRadius: .circular(16),),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: Stack(
          fit: .expand,
          children: [
            Transform.translate(
              offset: Offset(parallax * -28, 0),
              child: Transform.scale(
                scale: 1.12,
                child: const SizedBox()

               /* Image.asset(
                  banner.imagePath,
                  fit: .cover,
                  alignment: Alignment(-parallax * 0.6, 0),
                ),*/
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
                          /*decoration: BoxDecoration(
                            color: AppColors.promoTag,
                            borderRadius: .circular(70),
                            border: .all(color: AppColors.promoTagBorder, width: 0.5),
                          ),*/
                          //banner.tag, promoTag
                          child: const SizedBox()
                        ),
                        Column(
                          spacing: 8,
                          crossAxisAlignment: .start,
                          children: [
                            //banner.titleLine1, headlineMedium
                            //banner.titleLine2, headlineMedium.with color: textHeadlineAccent
                            //banner.subtitle, bodySmall
                          ],
                        ),
                      ],
                    ),
                    /*PrimaryButton(
                      label: StringConst.shopNow,
                      width: 112,
                      height: 34,
                      borderRadius: 12,
                      arrowSize: 12,
                      textStyle: AppTextStyles.buttonSmall,
                      onTap: () => context.push(NamedRoutes.skinAnalysis.routeName),
                    ),*/
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
        //flashSale, titleMedium
        //viewMore, labelSmall
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
    return Container(
      width: 130,
      height: 210,
      decoration: BoxDecoration(
       /* borderRadius: .circular(16),
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
        ],*/
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                //product.imagePath, 130, 130, .cover
                child: const SizedBox()
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
                    child: const SizedBox()
                   /* product.isFavorite
                        ? Icon(Icons.favorite, color: AppColors.primary,)
                        : SvgPicture.asset(AppIcons.icFavorite, height: 20,),*/
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
                    //product.name
                    child: Text(
                      '', maxLines: 2,
                      overflow: .ellipsis,
                      style: AppTextStyles.productTitle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      //\$${product.price.toStringAsFixed(2)}
                      Text('', style: AppTextStyles.price,),

                      // RatingLabel(rating: product.rating, reviewCount: product.reviewCount,),
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
