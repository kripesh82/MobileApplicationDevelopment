import 'package:buyer/viewmodel/home_view_model.dart';

import 'package:buyer/view/Home%20Screens/product_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/text_field.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Scaffold(
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          onRefresh: () {
            controller.swipeToRefresh();
            refreshController.refreshCompleted();
          },
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Foodly',
                          style: GoogleFonts.rubik(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange),
                        ),
                      ),
                      const Spacer(),
                      textField(
                        width: 69.w,
                        height: 7.5.h,
                        textType: TextInputType.name,
                        iconLead: Ionicons.search_outline,
                        iconSize: 24,
                        hintText: 'Search for a meal',
                        labelText: 'Search for a meal',
                        labelColor: AppColors.lightGrey,
                        labelFloating: FloatingLabelBehavior.never,
                        textSize: 18,
                        labelSize: 18,
                        hintSize: 14,
                        onSubmit: (value) {
                          controller.preformAllProductsSearch(value);
                        },
                      ),
                    ],
                  ),
                ),
                controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ImageSlideshow(
                        indicatorColor: AppColors.orange,
                        indicatorBackgroundColor: AppColors.lightGrey,
                        onPageChanged: (value) {},
                        autoPlayInterval: 2000,
                        width: 100.w,
                        height: 16.h,
                        isLoop: true,
                        children: controller.bannersURLs
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fill,
                              ),
                            )
                            .toList()),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.rubik(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange),
                  ),
                ),
                controller.loading.value
                    ? buildLoadingAnimationCategory()
                    : listViewCategory(),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 10),
                  child: Text(
                    'Best Selling',
                    style: GoogleFonts.rubik(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange),
                  ),
                ),
                controller.loading.value
                    ? buildLoadingAnimationBest()
                    : listViewProducts()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewCategory() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 15.h,
        child: ListView.separated(
          itemCount: controller.categoryModel.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 1.h,
                ),
                InkWell(
                  onTap: () {
                    controller.productModel.clear();
                    controller.getProductsByCategoryId(
                        controller.categoryModel[index].id!,
                        controller.categoryModel[index].name!);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(38, 255, 164, 89),
                        ),
                        height: 65,
                        width: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: CachedNetworkImage(
                            imageUrl: controller.categoryModel[index].image!,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        controller.categoryModel[index].name!,
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.h,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 0.w,
          ),
        ),
      ),
    );
  }

  Widget buildLoadingAnimationCategory() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightOrange,
      highlightColor: AppColors.lightGrey,
      child: SizedBox(
        height: 15.h,
        child: ListView.separated(
          itemCount: 6,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(38, 255, 164, 89),
                      ),
                      height: 65,
                      width: 65,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      color: const Color.fromARGB(38, 255, 164, 89),
                      height: 1.h,
                      width: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  width: 1.h,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 0.w,
          ),
        ),
      ),
    );
  }

  Widget listViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 36.h,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.bestModel.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                        () => ProductScreen(
                              productModel: controller.bestModel[index],
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
                                imageUrl: controller.bestModel[index].image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          controller.bestModel[index].name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          controller.bestModel[index].description!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Text(
                            'Rs. ${controller.bestModel[index].price!}',
                            style: GoogleFonts.rubik(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 0.w,
          ),
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
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
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
          separatorBuilder: (context, index) => SizedBox(
            width: 0.w,
          ),
        ),
      ),
    );
  }
}
