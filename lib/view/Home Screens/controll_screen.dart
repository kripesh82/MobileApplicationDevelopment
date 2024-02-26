// ignore_for_file: must_be_immutable

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:buyer/viewmodel/auth_view_model.dart';
import 'package:buyer/view/Welcome%20Screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../viewmodel/cart_view_model.dart';
import '../../viewmodel/control_view_model.dart';

class ControllScreen extends GetWidget<AuthViewModel> {
  const ControllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? const WelcomeScreen()
          : GetBuilder<ControlViewModel>(
              init: ControlViewModel(),
              builder: (controller) => Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: GetBuilder<ControlViewModel>(
                  init: ControlViewModel(),
                  builder: (controller) => BottomNavyBar(
                    selectedIndex: controller.navBarValue,
                    iconSize: 27,
                    showElevation: true,
                    containerHeight: 7.h,
                    curve: Curves.linear,
                    onItemSelected: (index) {
                      controller.changeScreensNavBar(index);
                    },
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                        icon: const Icon(Ionicons.home_outline),
                        title: const Text(
                          'Home Page',
                          textAlign: TextAlign.center,
                        ),
                        activeColor: AppColors.orange,
                        inactiveColor: Colors.black,
                      ),
                      BottomNavyBarItem(
                        icon: GetBuilder<CartViewModel>(
                          builder: (controller) => controller
                                  .cartProductModel.isEmpty
                              ? const Icon(Ionicons.cart_outline)
                              : Badge(
                                  backgroundColor: Colors.red,
                                  label: Text(controller.cartProductModel.length
                                      .toString()),
                                  child: const Icon(Ionicons.cart_outline)),
                        ),
                        title: const Text(
                          'Your Cart',
                          textAlign: TextAlign.center,
                        ),
                        textAlign: TextAlign.center,
                        activeColor: AppColors.orange,
                        inactiveColor: Colors.black,
                      ),
                      BottomNavyBarItem(
                        icon: const Icon(Ionicons.person_outline),
                        title: const Text(
                          'Your Profile',
                          textAlign: TextAlign.center,
                        ),
                        activeColor: AppColors.orange,
                        inactiveColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
