import 'package:buyer/model/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:buyer/utils/database/cart_database_helper.dart';

class MockCartDatabaseHelper extends Mock implements CartDatabaseHelper {}

    void main() {
        group('CartViewModel Tests', () {
            late CartViewModel viewModel;
            late MockCartDatabaseHelper mockDbHelper;

            setUp(() {
                mockDbHelper = MockCartDatabaseHelper();
                viewModel = CartViewModel();
                viewModel.dbHelper = mockDbHelper;
            });

            test('increaseQuan should increase quantity and update total price', () async {
                final initialQuantity = 1;
                final cartProductModel = CartProductModel(
                        name: 'Burger',
                        productId: '1',
                        quantity: initialQuantity,
                        price: '10.0',
      );

                viewModel.cartProductModel = [cartProductModel];
                viewModel.totalPrice = 10.0;

                when(mockDbHelper.updateProduct(any)).thenAnswer((_) async => true);

                await viewModel.increaseQuan(0);

                expect(viewModel.cartProductModel[0].quantity, initialQuantity + 1);
                expect(viewModel.totalPrice, 20.0);
            });

            test('decreaseQuan should decrease quantity and update total price', () async {
                final initialQuantity = 2;
                final cartProductModel = CartProductModel(
                        name: 'Burger',
                        productId: '1',
                        quantity: initialQuantity,
                        price: '10.0',
      );

                viewModel.cartProductModel = [cartProductModel];
                viewModel.totalPrice = 20.0;

                when(mockDbHelper.updateProduct(any)).thenAnswer((_) async => true);

                await viewModel.decreaseQuan(0);

                expect(viewModel.cartProductModel[0].quantity, initialQuantity - 1);
                expect(viewModel.totalPrice, 10.0);
            });
        });
    }
