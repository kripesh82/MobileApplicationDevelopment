// ignore_for_file: must_be_immutable

import 'package:buyer/viewmodel/cart_view_model.dart';
import 'package:buyer/viewmodel/home_view_model.dart';
import 'package:buyer/widgets/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../model/cart_product_model.dart';
import '../../model/product_model.dart';
import 'package:readmore/readmore.dart';

import '../../utils/services/theme_service.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key, this.productModel});

  ProductModel? productModel;
  final HomeViewModel controller = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(children: [
          SizedBox(
              height: 45.h,
              width: 100.h,
              child: CachedNetworkImage(
                imageUrl: productModel!.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Ionicons.chevron_back,
                size: 30,
                color: AppColors.orange,
              ),
            ),
          ),
          Positioned(
            top: 42.h,
            child: Container(
              width: 100.w,
              height: 6.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightOrange.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, -5),
                  ),
                ],
                color: ThemeService().isSavedDarkMode()
                    ? const Color.fromARGB(255, 49, 48, 49)
                    : const Color.fromARGB(255, 250, 251, 255),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          )
        ]),
        Expanded(
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: double.infinity,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productModel!.name!,
                      style: GoogleFonts.rubik(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Product details',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    ReadMoreText(
                      productModel!.description!,
                      textAlign: TextAlign.justify,
                      trimLines: 2,
                      colorClickableText: AppColors.orange,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' Show less',
                      moreStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange),
                      style: TextStyle(
                        fontSize: 11.sp,
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    // Text(
                    //   'Select Color',
                    //   style: TextStyle(
                    //       fontSize: 12.sp, fontWeight: FontWeight.bold),
                    // ),
                    //colorProperty(),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Select Size',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    sizeProperty(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: 100.w,
                  height: 16.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.white),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            'Rs. ${productModel!.price!}',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GetBuilder<CartViewModel>(
                        init: Get.put(CartViewModel()),
                        builder: (controller) => filledIconButton(
                          height: 6.h,
                          width: 50.w,
                          buttonText: 'Add to Cart',
                          buttonIcon: Icons.add_rounded,
                          buttonColor: Colors.white,
                          buttonTextColor: AppColors.orange,
                          iconSize: 33,
                          function: () {
                            controller.addProduct(CartProductModel(
                                name: productModel!.name,
                                price: productModel!.price,
                                image: productModel!.image,
                                quantity: 1,
                                productId: productModel!.productId));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget colorProperty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.orange,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 0.3.w,
                      ),
                      color: Colors.transparent,
                      shape: BoxShape.circle),
                  width: 6.w,
                  height: 6.w,
                  margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.orange, shape: BoxShape.circle),
                      width: 5.w,
                      height: 5.h,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  width: 6.w,
                  height: 6.w,
                  margin: const EdgeInsets.all(5),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  width: 6.w,
                  height: 6.w,
                  margin: const EdgeInsets.all(5),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.pink, shape: BoxShape.circle),
                  width: 6.w,
                  height: 6.w,
                  margin: const EdgeInsets.all(5),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget sizeProperty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                        style: BorderStyle.solid,
                        width: 0.3.w,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      shape: BoxShape.rectangle),
                  width: 10.5.w,
                  height: 4.5.h,
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                        style: BorderStyle.solid,
                        width: 0.3.w,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      shape: BoxShape.rectangle),
                  width: 10.5.w,
                  height: 4.5.h,
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: Center(
                    child: Text(
                      'M',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.orange,
                        style: BorderStyle.solid,
                        width: 0.3.w,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      shape: BoxShape.rectangle),
                  width: 10.5.w,
                  height: 4.5.h,
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: Center(
                    child: Text(
                      'L',
                      style:
                          TextStyle(fontSize: 16.sp, color: AppColors.orange),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                        style: BorderStyle.solid,
                        width: 0.3.w,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      shape: BoxShape.rectangle),
                  width: 10.5.w,
                  height: 4.5.h,
                  margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Center(
                    child: Text(
                      'XL',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
