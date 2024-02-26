import 'dart:developer';

import 'package:buyer/utils/services/home_service.dart';
import 'package:buyer/view/Home%20Screens/product_category_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../view/Home Screens/search_screen.dart';
import '../utils/services/products_service.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;

  List<CategoryModel> _categoryModel = [];

  List<CategoryModel> get categoryModel => _categoryModel;

  List<ProductModel> _productModel = [];

  List<ProductModel> get productModel => _productModel;

  List<ProductModel> _productModelFilter = [];

  List<ProductModel> get productModelFilter => _productModelFilter;

  List<ProductModel> _allProductModelFilter = [];

  List<ProductModel> get allProductModelFilter => _allProductModelFilter;

  List<ProductModel> _bestModel = [];

  List<ProductModel> get bestModel => _bestModel;

  List<ProductModel> _allProductModel = [];

  List<ProductModel> get allProductModel => _allProductModel;

  List<String> bannersURLs = [];

  bool _searchBoolean = false;
  bool get searchBoolean => _searchBoolean;

  bool isLoading = true;

  @override
  void onInit() async {
    super.onInit();
    await getBanners();
    _productModelFilter = _productModel;
    isLoading = false;
    update();
  }

  searchTrigger(bool state) {
    _searchBoolean = state;
    update();
  }

  filterRestate() {
    _productModelFilter = _productModel;
    update();
  }

  preformProductsSearch(String searched) {
    if (searched.isEmpty) {
      _productModelFilter = _productModel;
    } else {
      _productModelFilter = _productModel
          .where((data) =>
          data.name!.toLowerCase().contains(searched.toLowerCase()))
          .toList();
    }
    update();
  }

  preformAllProductsSearch(String searched) {
    _allProductModelFilter = _allProductModel
        .where(
            (data) => data.name!.toLowerCase().contains(searched.toLowerCase()))
        .toList();

    if (searched.isNotEmpty) {
      Get.to(
              () => SearchScreen(
            title: searched,
          ),
          duration: const Duration(milliseconds: 700),
          transition: Transition.downToUp);
    } else {
      Get.snackbar('Process Failed', 'Please enter any text to search for.',
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  swipeToRefresh() {
    categoryModel.clear();
    getCategory();
    bestModel.clear();
    getBestSelling();
    bannersURLs.clear();
    getBanners();
    update();
  }

  HomeViewModel() {
    getCategory();
    getBestSelling();
    getAllProducts();
    getBanners();
  }

  getAllProducts() async {
    _loading.value = true;
    ProductService().getAllProducts().then((value) {
      for (int i = 0; i < value.length; i++) {
        _allProductModel.add(
            ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
      update();
    }).then((value) => _loading.value = false);
  }

  getCategory() async {
    _loading.value = true;
    HomeService().getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categoryModel.add(
            CategoryModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }

      update();
    }).then((value) => _loading.value = false);
  }

  getBestSelling() async {
    _loading.value = true;
    HomeService().getBestSelling().then((value) {
      for (int i = 0; i < value.length; i++) {
        _bestModel.add(
            ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }

      update();
    }).then((value) => _loading.value = false);
  }

  getBanners() async {
    _loading.value = true;
    await HomeService().getBanners().then((value) {
      bannersURLs = value;
      update();
    }).then((value) => _loading.value = false);
  }

  getProductsByCategoryId(String id, String category) async {
    _loading.value = true;
    switch (id) {
      case '1':
        await ProductService().getBurgerProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;

      case '2':
        await ProductService().getPizzaProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;

      case '3':
        await ProductService().getMomoProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;

      case '4':
        await ProductService().getChowmeinProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;

      case '5':
        await ProductService().getSamosaProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;

      case '6':
        await ProductService().getBeerProducts().then((value) {
          for (int i = 0; i < value.length; i++) {
            _productModel.add(ProductModel.fromJson(
                value[i].data() as Map<dynamic, dynamic>));
          }
        }).then((value) => _loading.value = false);
        break;
    }
    _productModelFilter = _productModel;
    Get.to(() => ProductCategoryScreen(title: category),
        duration: const Duration(milliseconds: 700),
        transition: Transition.downToUp);
    update();
  }
}
