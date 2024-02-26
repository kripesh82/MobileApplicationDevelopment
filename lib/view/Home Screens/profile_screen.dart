import 'package:buyer/view/Settings%20Screens/billing_screen.dart';
import 'package:buyer/viewmodel/account_view_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

import '../../constants/colors.dart';
import '../../utils/services/theme_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountViewModel>(
      init: AccountViewModel(),
      builder: (controller) => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 1.h),
            Text(
              "Your Profile",
              style: GoogleFonts.rubik(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange),
            ),
            controller.loading.value
                ? shimmerLoader()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white.withOpacity(.15),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 400,
                              backgroundColor: Colors.white.withOpacity(.1),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.white.withOpacity(.05),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          height: 13.5.h,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          imageUrl: controller.userModel.pic!,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.userModel.name!,
                                            style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            controller.userModel.email!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /*Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                height: 4.h,
                                width: 8.w,
                                margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                decoration: const BoxDecoration(
                                    color: Colors.white, shape: BoxShape.circle),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => EditProfileScreen(),
                                        duration:
                                            const Duration(milliseconds: 700),
                                        transition: Transition.zoom);
                                  },
                                  highlightColor: AppColors.orange,
                                  child: const Icon(
                                    Ionicons.pencil,
                                    color: AppColors.orange,
                                    size: 20,
                                  ),
                                )),
                          ),*/
                        ],
                      ),
                    )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SettingsGroup(items: [
                SettingsItem(
                  onTap: () {
                    Get.to(() => BillingScreen(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.zoom);
                  },
                  icons: Ionicons.home_outline,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: AppColors.orange,
                  ),
                  title: 'Billing',
                  subtitle: "Edit your billing information",
                ),
                SettingsItem(
                  icons: Ionicons.moon_outline,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.grey,
                  ),
                  title: 'Dark mode',
                  subtitle: 'Make app in dark mood theme',
                  trailing: Switch(
                    activeColor: AppColors.orange,
                    value: ThemeService().isSavedDarkMode(),
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                      ThemeService().changeTheme();
                    },
                  ),
                ),
                SettingsItem(
                  onTap: () async {
                    await controller.launchCustomerSupport();
                  },
                  icons: Icons.support_agent_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.green,
                  ),
                  title: 'Customer Support',
                  subtitle: 'Contact us if you have problem',
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SettingsGroup(items: [
                SettingsItem(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return CupertinoAlertDialog(
                            title: const Text('Please Confirm'),
                            content: const Text('Are you sure to sign out?'),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  controller.signOut();
                                },
                                isDefaultAction: true,
                                isDestructiveAction: true,
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                      color: AppColors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  Get.back();
                                },
                                isDefaultAction: false,
                                isDestructiveAction: false,
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icons: Ionicons.log_out_outline,
                  titleStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  trailing: const Icon(Icons.navigate_next, color: Colors.red),
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Sign Out',
                  subtitle: 'Sign out of your account',
                ),
              ]),
            )
          ],
        ),
      ))),
    );
  }

  Widget shimmerLoader() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightOrange,
      highlightColor: AppColors.lightGrey,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(.15),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 400,
                    backgroundColor: Colors.white.withOpacity(.1),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(.05),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
