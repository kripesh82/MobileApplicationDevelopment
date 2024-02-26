import 'package:buyer/view/Checkout%20Screens/payment_screen.dart';
import 'package:buyer/view/Settings%20Screens/billing_screen.dart';
import 'package:buyer/viewmodel/billing_view_model.dart';
import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedIndex = 0;

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
            'Checkout',
            style: TextStyle(fontSize: 22, color: AppColors.orange),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                  child: Text(
                    'Order Products',
                    style: GoogleFonts.rubik(
                        fontSize: 13.sp,
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GetBuilder<CartViewModel>(
                    builder: (controller) => SizedBox(
                          height: 18.h,
                          width: 100.w,
                          child: ListView.builder(
                              itemCount: controller.cartProductModel.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 13.h,
                                                width: 30.w,
                                                color: Colors.transparent,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .cartProductModel[index]
                                                        .image!,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 0.5.h),
                                              Text(
                                                controller
                                                    .cartProductModel[index]
                                                    .name!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                              SizedBox(height: 0.1.h),
                                              Text(
                                                '${controller.cartProductModel[index].quantity!} X ${controller.cartProductModel[index].price!} ',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.orange),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                  child: Row(
                    children: [
                      Text(
                        'Billing Address',
                        style: GoogleFonts.rubik(
                            fontSize: 13.sp,
                            color: AppColors.orange,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => BillingScreen(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.zoom);
                        },
                        child: const Icon(
                          Ionicons.add_circle_outline,
                          color: AppColors.orange,
                        ),
                      )
                    ],
                  ),
                ),
                GetBuilder<BillingViewModel>(
                    init: BillingViewModel(),
                    builder: (controller) => SizedBox(
                          height: 11.h,
                          width: 100.w,
                          child: controller.billingList.isEmpty
                              ? Center(
                                  child: Text(
                                    'You must add an address to place the order',
                                    style: GoogleFonts.rubik(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.billingList.length,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    bool isSelected = index == _selectedIndex;
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          },
                                          child: Container(
                                              height: 10.h,
                                              width: 40.w,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: AppColors.orange
                                                      .withOpacity(0.13),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: isSelected
                                                        ? AppColors.orange
                                                        : Colors.transparent,
                                                  )),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .billingList[index]
                                                          .name!,
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 0.2.h,
                                                    ),
                                                    Text(
                                                      controller
                                                          .billingList[index]
                                                          .city!,
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          color:
                                                              AppColors.orange),
                                                    ),
                                                    SizedBox(
                                                      height: 0.2.h,
                                                    ),
                                                    Text(
                                                      controller
                                                          .billingList[index]
                                                          .address!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 9.sp,
                                                          color: AppColors
                                                              .darkGrey),
                                                    ),
                                                    SizedBox(
                                                      height: 0.2.h,
                                                    ),
                                                    Text(
                                                      controller
                                                          .billingList[index]
                                                          .phone!,
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                      ),
                                                    ),
                                                  ])),
                                        ),
                                      ],
                                    );
                                  }),
                        )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                  child: Text(
                    'Order Summary',
                    style: GoogleFonts.rubik(
                        fontSize: 13.sp,
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GetBuilder<CartViewModel>(
                    builder: (controller) => MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.cartProductModel.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller
                                            .cartProductModel[index].name!,
                                        style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        'X ${controller.cartProductModel[index].quantity!}',
                                        style: GoogleFonts.rubik(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.orange),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${controller.cartProductModel[index].price!}',
                                        style: GoogleFonts.rubik(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.orange),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )),
                GetBuilder<CartViewModel>(
                  builder: (controller) => Column(
                    children: [
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        color: AppColors.darkGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Shipping',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '50',
                              style: GoogleFonts.rubik(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Tax fee',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '0 ',
                              style: GoogleFonts.rubik(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        color: AppColors.darkGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                                fontSize: 15.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Rs. ${controller.totalPrice + 50} ',
                              style: GoogleFonts.rubik(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<BillingViewModel>(
                  init: BillingViewModel(),
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: filledButton(
                      height: 6.h,
                      width: 100.w,
                      buttonText: 'Proceed To Payment',
                      textSize: 13.sp,
                      buttonColor: AppColors.orange,
                      buttonTextColor: Colors.white,
                      function: () {
                        if (controller.billingList.isNotEmpty) {
                          Get.to(() => const PaymentScreen(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.rightToLeft);
                        } else {
                          Get.snackbar('Process Faield',
                              'You must add an address to place the order.',
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 1),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
