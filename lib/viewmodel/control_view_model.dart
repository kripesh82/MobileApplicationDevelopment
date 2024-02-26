import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/Home Screens/cart_screen.dart';
import '../view/Home Screens/home_screen.dart';
import '../view/Home Screens/profile_screen.dart';

class ControlViewModel extends GetxController {
  int _navBarValue = 0;

  get navBarValue => _navBarValue;

  Widget _currentScreen = const HomeScreen();

  get currentScreen => _currentScreen;

  void changeScreensNavBar(int selectedItem) {
    _navBarValue = selectedItem;
    switch (selectedItem) {
      case 0:
        {
          _currentScreen = const HomeScreen();
          break;
        }
      case 1:
        {
          _currentScreen = const CartScreen();
          break;
        }
      case 2:
        {
          _currentScreen = const ProfileScreen();
          break;
        }
    }
    update();
  }
}
