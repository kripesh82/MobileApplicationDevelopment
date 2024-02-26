import 'package:buyer/view/Checkout%20Screens/check_out_screen.dart';
import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: Get.put(CartViewModel()),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1.h),
              Text(
                "Your Cart",
                style: GoogleFonts.rubik(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange),
              ),
              SizedBox(height: 2.h),
              controller.cartProductModel.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              image: const AssetImage(
                                  "assets/images/empty_cart.png"),
                              height: 20.h,
                            ),
                            Text(
                              "\t\t\t\t\t\tYour cart is empty",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: controller.loading.value
                          ? shimmerLoader()
                          : ListView.builder(
                              itemCount: controller.cartProductModel.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 3.h),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: 18.h,
                                          width: 18.h,
                                          color: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .cartProductModel[index]
                                                  .image!,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              controller.cartProductModel[index]
                                                  .name!,
                                              style: GoogleFonts.rubik(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text(
                                              'Rs. ${controller.cartProductModel[index].price!} ',
                                              style: GoogleFonts.rubik(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.orange),
                                            ),
                                            SizedBox(height: 1.h),
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: AppColors.lightGrey
                                                        .withOpacity(0.3),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        child: const Icon(
                                                          Ionicons
                                                              .remove_circle_outline,
                                                        ),
                                                        onTap: () {
                                                          if (1 <
                                                              controller
                                                                  .cartProductModel[
                                                                      index]
                                                                  .quantity!) {
                                                            controller
                                                                .decreaseQuan(
                                                                    index);
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      Text(
                                                        controller
                                                            .cartProductModel[
                                                                index]
                                                            .quantity!
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.rubik(
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      InkWell(
                                                        child: const Icon(
                                                          Ionicons
                                                              .add_circle_outline,
                                                        ),
                                                        onTap: () {
                                                          controller
                                                              .increaseQuan(
                                                                  index);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      controller.deleteProduct(
                                                          controller
                                                                  .cartProductModel[
                                                              index]);
                                                      controller
                                                          .cartProductModel
                                                          .removeAt(index);
                                                    },
                                                    icon: Icon(
                                                      Ionicons
                                                          .trash_bin_outline,
                                                      color: Colors.red,
                                                      size: 3.6.h,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: AppColors.darkGrey,
              ),
              Container(
                height: 9.h,
                width: 100.w,
                margin: EdgeInsets.only(bottom: 1.h),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        SizedBox(height: 0.4.h),
                        GetBuilder<CartViewModel>(
                          init: Get.find(),
                          builder: (controller) => Text(
                            "Rs. ${controller.totalPrice}",
                            style: GoogleFonts.rubik(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    filledButton(
                      height: 6.h,
                      width: 47.w,
                      buttonText: 'Proceed To Checkout',
                      textSize: 13.sp,
                      buttonColor: AppColors.orange,
                      buttonTextColor: Colors.white,
                      function: () {
                        if (controller.cartProductModel.isEmpty) {
                          Get.snackbar('Process Faield', 'Your cart is empty.',
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 1),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          Get.to(() => const CheckoutScreen(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.rightToLeft);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerLoader() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightOrange,
      highlightColor: AppColors.lightGrey,
      child: ListView.builder(
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 3.h),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 18.h,
                    width: 18.h,
                    color: const Color.fromARGB(38, 255, 164, 89),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 2.h,
                        width: 18.h,
                        color: const Color.fromARGB(38, 255, 164, 89),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        height: 2.h,
                        width: 18.h,
                        color: const Color.fromARGB(38, 255, 164, 89),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
