import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../utils/services/theme_service.dart';
import '../../viewmodel/billing_view_model.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_field.dart';

class BillingScreen extends StatelessWidget {
  BillingScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillingViewModel>(
      init: BillingViewModel(),
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
          title: const Text(
            'Billing Information',
            style: TextStyle(fontSize: 22, color: AppColors.orange),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.billingList.isEmpty
                  ? SizedBox(
                      height: 0.h,
                    )
                  : MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.billingList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                  height: 16.h,
                                  width: 100.w,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                    color: AppColors.orange.withOpacity(0.13),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              controller
                                                  .billingList[index].name!,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  controller
                                                      .removeBilling(index);
                                                },
                                                child: const Icon(
                                                  Ionicons.trash_bin_outline,
                                                  size: 24,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          controller.billingList[index].city!,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.orange),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          controller
                                              .billingList[index].address!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.darkGrey),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          controller.billingList[index].phone!,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ])),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                textField(
                                  width: 100.w,
                                  textType: TextInputType.name,
                                  iconLead: Ionicons.person_outline,
                                  iconSize: 28,
                                  hintText: 'Robert J. Stone',
                                  textSize: 16,
                                  labelSize: 16,
                                  hintSize: 16,
                                  labelText: 'Reciver Name',
                                  onSave: (value) {
                                    controller.name = value;
                                  },
                                ),
                                textField(
                                  width: 100.w,
                                  textType: TextInputType.streetAddress,
                                  iconLead: Ionicons.map_outline,
                                  iconSize: 28,
                                  hintText: 'Suez, Egypt',
                                  textSize: 16,
                                  labelSize: 16,
                                  hintSize: 16,
                                  labelText: 'City',
                                  onSave: (value) {
                                    controller.city = value;
                                  },
                                ),
                                textField(
                                  width: 100.w,
                                  textType: TextInputType.streetAddress,
                                  iconLead: Ionicons.location_outline,
                                  iconSize: 28,
                                  hintText: '3839 Ingram Road',
                                  textSize: 16,
                                  labelSize: 16,
                                  hintSize: 16,
                                  labelText: 'Street Address',
                                  onSave: (value) {
                                    controller.address = value;
                                  },
                                ),
                                textField(
                                  width: 100.w,
                                  textType: TextInputType.phone,
                                  iconLead: Ionicons.phone_portrait_outline,
                                  iconSize: 28,
                                  hintText: '+201410102928',
                                  textSize: 16,
                                  labelSize: 16,
                                  hintSize: 16,
                                  labelText: 'Phone Number',
                                  onSave: (value) {
                                    controller.phone = value;
                                  },
                                ),
                                filledButton(
                                  buttonText: 'Save Address',
                                  height: 50,
                                  width: 100.w,
                                  function: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    formKey.currentState!.save();

                                    if (formKey.currentState!.validate()) {
                                      controller.addBilling();
                                      Get.isBottomSheetOpen!
                                          ? Get.back()
                                          : null;
                                      Get.snackbar('Process Success',
                                          'Saved Address Successfully.',
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else {
                                      Get.snackbar('Process Failed',
                                          'Saved Address Failed.',
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);
                                      Get.back();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: ThemeService().isSavedDarkMode()
                          ? const Color.fromARGB(255, 49, 48, 49)
                          : const Color.fromARGB(255, 250, 251, 255),
                      ignoreSafeArea: false,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))));
                },
                child: Container(
                  height: 16.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Ionicons.add_outline,
                        color: AppColors.lightOrange,
                        size: 70,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Add new address',
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: AppColors.lightOrange),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
