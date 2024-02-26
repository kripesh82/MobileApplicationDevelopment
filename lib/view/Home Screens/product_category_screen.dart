// ignore_for_file: must_be_immutable

import 'package:buyer/view/Home%20Screens/product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../viewmodel/home_view_model.dart';

class ProductCategoryScreen extends StatelessWidget {
  ProductCategoryScreen({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                controller.searchTrigger(false);
                Get.back();
              },
              icon: const Icon(
                Ionicons.chevron_back,
              ),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColors.orange),
            centerTitle: true,
            title: !controller.searchBoolean
                ? Text(
                    title,
                    style: GoogleFonts.rubik(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange),
                  )
                : _searchTextField(),
            actions: !controller.searchBoolean
                ? [
                    IconButton(
                        icon: const Icon(Ionicons.search_outline),
                        onPressed: () {
                          controller.searchTrigger(true);
                        })
                  ]
                : [
                    IconButton(
                        icon: const Icon(Ionicons.trash_bin_outline),
                        onPressed: () {
                          controller.searchTrigger(false);
                        })
                  ]),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Expanded(
                  child: controller.loading.value
                      ? buildLoadingAnimationBest()
                      : gridViewProducts())
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => TextField(
        onChanged: (value) {
          controller.preformProductsSearch(value);
        },
        onTapOutside: (event) {
          controller.searchTrigger(false);
        },
        autofocus: true,
        cursorColor: AppColors.orange,
        style: TextStyle(
          fontSize: 14.sp,
        ),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange)),
          hintText: 'Search for a meal...',
          hintStyle: TextStyle(
            color: AppColors.darkGrey,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget gridViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.6),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.productModelFilter.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                        () => ProductScreen(
                              productModel:
                                  controller.productModelFilter[index],
                            ),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.downToUp);
                    Future.delayed(const Duration(milliseconds: 900), () {
                      controller.filterRestate();
                    });
                  },
                  child: SizedBox(
                    width: 40.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 24.h,
                          width: 20.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl:
                                    controller.productModelFilter[index].image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.productModelFilter[index].name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          controller.productModelFilter[index].description!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Rs. ${controller.productModelFilter[index].price!}',
                          style: GoogleFonts.rubik(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildLoadingAnimationBest() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightOrange,
      highlightColor: AppColors.lightGrey,
      child: SizedBox(
        height: 36.h,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                SizedBox(
                  width: 40.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: const Color.fromARGB(38, 255, 164, 89),
                        height: 24.h,
                        width: 20.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        color: const Color.fromARGB(38, 255, 164, 89),
                        height: 1.h,
                        width: 40.w,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        color: const Color.fromARGB(38, 255, 164, 89),
                        height: 1.h,
                        width: 40.w,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        color: const Color.fromARGB(38, 255, 164, 89),
                        height: 1.h,
                        width: 20.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
