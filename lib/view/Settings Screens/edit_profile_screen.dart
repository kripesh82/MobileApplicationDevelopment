// ignore_for_file: must_be_immutable

import 'package:buyer/model/user_model.dart';
import 'package:buyer/viewmodel/account_view_model.dart';
import 'package:buyer/viewmodel/auth_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../utils/services/theme_service.dart';

import '../../widgets/buttons.dart';
import '../../widgets/text_field.dart';
import '../Home Screens/controll_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

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
          'Edit Your Profile',
          style: TextStyle(fontSize: 22, color: AppColors.orange),
        ),
      ),
      body: GetBuilder<AccountViewModel>(
        init: AccountViewModel(),
        builder: (controller) {
          nameController.text = controller.userModel.name!;
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      builder: (authController) => Stack(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                              child: authController.imageFile == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        imageUrl: controller.userModel.pic!,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        authController.imageFile!,
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200,
                                      ),
                                    )),
                          Positioned(
                            top: 160,
                            right: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: ThemeService().isSavedDarkMode()
                                      ? const Color.fromARGB(255, 49, 48, 49)
                                      : const Color.fromARGB(
                                          255, 250, 251, 255),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: AppColors.orange,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Ionicons.images_outline,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    authController.getImage();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    textField(
                      width: 100.w,
                      textType: TextInputType.name,
                      iconLead: Ionicons.person_outline,
                      iconSize: 28,
                      hintText: 'Kripesh Poudel',
                      textFormController: nameController,
                      textSize: 16,
                      labelSize: 16,
                      hintSize: 16,
                      labelText: 'Name',
                    ),
                    textField(
                      width: 100.w,
                      textType: TextInputType.emailAddress,
                      iconLead: Ionicons.mail_outline,
                      iconSize: 28,
                      textFormController: TextEditingController(
                          text: controller.userModel.email),
                      hintText: 'kripesh@gmail.com',
                      readOnly: true,
                      textSize: 16,
                      labelSize: 16,
                      hintSize: 16,
                      labelText: 'Email Address',
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      builder: (authController) => filledButton(
                        buttonText: 'Update Your Profile',
                        height: 50,
                        width: 100.w,
                        function: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            authController.showPrograssDialog();
                            if (authController.imageFile != null) {
                              try {
                                String fileName =
                                    authController.imageFile!.path;
                                UploadTask? uploadTask =
                                    authController.uploadImage(
                                        authController.imageFile!, fileName);
                                TaskSnapshot? snapshot = await uploadTask;
                                String photoUrl =
                                    await snapshot!.ref.getDownloadURL();
                                UserModel userModel = UserModel(
                                    userId: controller.userModel.userId,
                                    name: nameController.value.text,
                                    email: controller.userModel.email,
                                    pic: photoUrl);

                                authController.updateCurrentUserData(userModel);
                                authController.hidePrograssDialog();

                                Get.offAll(() {
                                  return const ControllScreen();
                                },
                                    duration: const Duration(milliseconds: 700),
                                    transition: Transition.zoom);

                                Get.snackbar('Process Successful',
                                    'Your profile updated successfully.',
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM);
                              } catch (e) {
                                Get.snackbar('Process Faild',
                                    'Failed to update your profile.',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM);
                                authController.hidePrograssDialog();
                              }
                            } else {
                              UserModel userModel = UserModel(
                                  userId: controller.userModel.userId,
                                  name: nameController.value.text,
                                  email: controller.userModel.email,
                                  pic: controller.userModel.pic);

                              authController.updateCurrentUserData(userModel);
                              authController.hidePrograssDialog();

                              Get.offAll(() {
                                return const ControllScreen();
                              },
                                  duration: const Duration(milliseconds: 700),
                                  transition: Transition.zoom);

                              Get.snackbar('Process Successful',
                                  'Your profile updated successfully.',
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            Get.snackbar('Process Faild',
                                'Failed to update your profile.',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM);
                            authController.hidePrograssDialog();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
