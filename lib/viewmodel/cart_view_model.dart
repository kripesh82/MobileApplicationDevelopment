import 'package:buyer/utils/database/cart_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/cart_product_model.dart';

class CartViewModel extends GetxController {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  resetTotalPrice() {
    _totalPrice = 0.0;
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        Get.snackbar('Process Faield', 'Product is already at your cart.',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }

    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
    Get.snackbar(
        'Process Successful', 'Product added to your cart successfully.',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);

    update();
  }

  deleteProduct(CartProductModel cartProductModel) async {
    await dbHelper.deleteProduct(cartProductModel);
    _totalPrice -=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
    Get.snackbar(
        'Process Successful', 'Product removed from your cart successfully.',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);

    update();
  }

  deleteAllProductsFromCart() async {
    await dbHelper.deleteAllProduct();
  }

  getAllProduct() async {
    _loading.value = true;
    _cartProductModel = await dbHelper.getAllProduct();
    _loading.value = false;
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(_cartProductModel[i].price!) *
          _cartProductModel[i].quantity!);
    }
    update();
  }

  increaseQuan(int index) async {
    _cartProductModel[index].quantity = _cartProductModel[index].quantity! + 1;
    _totalPrice += (double.parse(_cartProductModel[index].price!));
    await dbHelper.updateProduct(_cartProductModel[index]);
    update();
  }

  decreaseQuan(int index) async {
    _cartProductModel[index].quantity = _cartProductModel[index].quantity! - 1;
    _totalPrice -= (double.parse(_cartProductModel[index].price!));
    await dbHelper.updateProduct(_cartProductModel[index]);
    update();
  }
}
