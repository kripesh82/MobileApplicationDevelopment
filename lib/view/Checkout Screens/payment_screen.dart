import 'package:buyer/view/Checkout%20Screens/add_card_screen.dart';
import 'package:buyer/view/Checkout%20Screens/finish_screen.dart';
import 'package:buyer/viewmodel/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Ionicons.chevron_back,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.orange),
        centerTitle: true,
        title: const Text(
          'Payment Method',
          style: TextStyle(fontSize: 22, color: AppColors.orange),
        ),
      ),
      body: GetBuilder<PaymentViewModel>(
        init: PaymentViewModel(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Method',
                style: GoogleFonts.rubik(
                    fontSize: 13.sp,
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.h),
              Container(
                  height: 8.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            _value == 1 ? AppColors.orange : AppColors.darkGrey,
                        width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.delivery_dining_outlined),
                        SizedBox(width: 3.w),
                        Text(
                          'Cash On Delivery',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Radio(
                          value: 1,
                          groupValue: _value,
                          activeColor: AppColors.orange,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                            controller.toggelAddCrad();
                          },
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 3.h),
              Container(
                  height: 8.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            _value == 2 ? AppColors.orange : AppColors.darkGrey,
                        width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.payment_outlined),
                        SizedBox(width: 3.w),
                        Text(
                          'Pay With Card',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Radio(
                          value: 2,
                          groupValue: _value,
                          activeColor: AppColors.orange,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                            controller.toggelAddCrad();
                          },
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 3.h),
              filledButton(
                height: 6.h,
                width: 100.w,
                buttonText: 'Place Order',
                textSize: 13.sp,
                buttonColor: AppColors.orange,
                buttonTextColor: Colors.white,
                function: () {
                  if (controller.addCard) {
                    if (controller.cardAdded) {
                      Get.offAll(() => const FinishScreen(),
                          duration: const Duration(milliseconds: 700),
                          transition: Transition.rightToLeft);
                    } else {
                      Get.snackbar('Process Failed', 'There is no card added.',
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  } else {
                    Get.to(() => const FinishScreen(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.rightToLeft);
                  }
                },
              ),
              SizedBox(height: 3.h),
              controller.addCard
                  ? outlineButton(
                      height: 6.h,
                      width: 100.w,
                      buttonText: 'Add Card',
                      textSize: 13.sp,
                      buttonColor: AppColors.orange,
                      function: () {
                        Get.to(() => const AddCardScreen(),
                            duration: const Duration(milliseconds: 700),
                            transition: Transition.rightToLeft);
                      },
                    )
                  : const SizedBox(
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
