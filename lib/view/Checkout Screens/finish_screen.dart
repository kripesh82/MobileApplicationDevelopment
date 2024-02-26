import 'dart:async';

import 'package:buyer/constants/colors.dart';
import 'package:buyer/view/Home%20Screens/controll_screen.dart';
import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/buttons.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  CartViewModel cartViewModel = Get.put(CartViewModel());
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 10), doDelay);
  }

  void doDelay() {
    cartViewModel.cartProductModel.clear();
    cartViewModel.deleteAllProductsFromCart();
    cartViewModel.resetTotalPrice();
    Get.offAll(() =>  const ControllScreen(),
        duration: const Duration(milliseconds: 700),
        transition: Transition.zoom);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/submit.png",
                fit: BoxFit.cover,
                color: AppColors.orange,
                width: 40.w,
              ),
              SizedBox(height: 5.h),
              Text(
                "Order Submited",
                style: GoogleFonts.rubik(
                  color: AppColors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Order placed and submited successfully",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 7.h),
              Text(
                "You will be redirected to the home page shortly\nor click here to return to home page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 0.5.h),
              Padding(
                padding: const EdgeInsets.all(20),
                child: filledButton(
                  height: 6.h,
                  width: 80.w,
                  buttonText: 'Back To Home',
                  textSize: 13.sp,
                  buttonColor: AppColors.orange,
                  buttonTextColor: Colors.white,
                  function: () {
                    controller.cartProductModel.clear();
                    controller.deleteAllProductsFromCart();
                    controller.resetTotalPrice();
                    timer.cancel();
                    Get.offAll(() =>  const ControllScreen(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.zoom);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
