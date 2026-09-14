import 'package:flutter/material.dart';
import 'package:skincare/core/app_data.dart';
import 'package:skincare/core/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final pageController = PageController();
  int selectedCategoryIndex = 0;
  int bannerIndex = 0;
  List<ProductModel> products = List.of(AppData.flashSaleProducts);

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void setBannerIndex(int index) {
    bannerIndex = index;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    final product = products[index];
    products[index] = product.copyWith(isFavorite: !product.isFavorite);
    notifyListeners();
  }

  double get bannerPage {
    if (!pageController.hasClients) return bannerIndex.toDouble();
    return pageController.page ?? bannerIndex.toDouble();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
