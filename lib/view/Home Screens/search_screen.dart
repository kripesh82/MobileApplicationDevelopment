// ignore_for_file: must_be_immutable

import 'package:buyer/view/Home%20Screens/product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../viewmodel/home_view_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.title});
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
                Get.back();
              },
              icon: const Icon(
                Ionicons.chevron_back,
              ),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColors.orange),
            centerTitle: true,
            title: Text(
              'Searching for: $title',
              style: GoogleFonts.rubik(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange),
            )),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Expanded(child: gridViewProducts())
            ],
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
          itemCount: controller.allProductModelFilter.length,
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
                                  controller.allProductModelFilter[index],
                            ),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.downToUp);
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
                                imageUrl: controller
                                    .allProductModelFilter[index].image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.allProductModelFilter[index].name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          controller.allProductModelFilter[index].description!,
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
                          'Rs. ${controller.allProductModelFilter[index].price!} ',
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
}
