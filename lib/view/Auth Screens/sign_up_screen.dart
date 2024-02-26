// ignore_for_file: must_be_immutable

import 'package:buyer/view/Auth%20Screens/sign_in_screen.dart';
import 'package:buyer/viewmodel/auth_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_field.dart';

class SignUpScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.orange),
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 22, color: AppColors.orange),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: const AssetImage('assets/images/back.png'),
              width: 100.w,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Here We Go!',
                        style: GoogleFonts.rubik(
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.orange),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign Up with an email and password \nor continue with Google',
                        style: GoogleFonts.rubik(
                            fontSize: 11.sp, color: AppColors.lightGrey),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textField(
                      width: 100.w,
                      textType: TextInputType.name,
                      iconLead: Ionicons.person_outline,
                      iconSize: 28,
                      hintText: 'Kripesh Poudel',
                      textSize: 16,
                      labelSize: 16,
                      hintSize: 16,
                      labelText: 'Name',
                      onSave: (value) {
                        controller.name = value;
                      },
                    ),
                    textField(
                      width: 100.w,
                      textType: TextInputType.emailAddress,
                      iconLead: Ionicons.mail_outline,
                      iconSize: 28,
                      hintText: 'kripesh82@gmail.com',
                      textSize: 16,
                      labelSize: 16,
                      hintSize: 16,
                      labelText: 'Email Address',
                      onSave: (value) {
                        controller.email = value;
                      },
                    ),
                    Obx(
                      () => textField(
                        width: 100.w,
                        textType: TextInputType.visiblePassword,
                        iconLead: Ionicons.lock_closed_outline,
                        iconSize: 28,
                        hintText: '••••••••••••••••••',
                        textSize: 16,
                        labelSize: 16,
                        hintSize: 16,
                        textFormController: passwordController,
                        isLength: true,
                        isRegex: true,
                        labelText: 'Password',
                        needSuffix: true,
                        onSave: (value) {
                          controller.password = value;
                        },
                        isPassword: !controller.isVisible.value,
                        iconSuffix: controller.isVisible.value
                            ? Ionicons.eye_off_outline
                            : Ionicons.eye_outline,
                        function: () {
                          controller.toggleObscure();
                        },
                      ),
                    ),
                    Obx(
                      () => textField(
                        width: 100.w,
                        textType: TextInputType.visiblePassword,
                        iconLead: Ionicons.lock_closed_outline,
                        iconSize: 28,
                        hintText: '••••••••••••••••••',
                        textFormController: passwordConfirmController,
                        textSize: 16,
                        labelSize: 16,
                        hintSize: 16,
                        isLength: true,
                        isRegex: true,
                        labelText: 'Confirm Password',
                        needSuffix: true,
                        onSave: (value) {
                          controller.passwordConfirm = value;
                        },
                        isPassword: !controller.isVisible.value,
                        iconSuffix: controller.isVisible.value
                            ? Ionicons.eye_off_outline
                            : Ionicons.eye_outline,
                        function: () {
                          controller.toggleObscure();
                        },
                      ),
                    ),
                    filledButton(
                      buttonText: 'Sign Up',
                      height: 50,
                      width: 100.w,
                      function: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _formKey.currentState!.save();
                        if (passwordController.value.text ==
                            passwordConfirmController.value.text) {
                          if (_formKey.currentState!.validate()) {
                            controller.emailAndPassSignUp();
                          }
                        } else {
                          Get.snackbar('Error with Sign Up !',
                              'Passwords not match each other',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Or you can sign up with',
                        style: GoogleFonts.rubik(
                            fontSize: 11.sp, color: AppColors.lightGrey),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    FloatingActionButton(
                      heroTag: 'fab2',
                      onPressed: () {
                        controller.googleSignIn();
                      },
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 4.h,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.rubik(
                              fontSize: 11.sp, color: AppColors.lightGrey),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(() => SignInScreen(),
                                duration: const Duration(milliseconds: 700),
                                transition: Transition.zoom);
                          },
                          highlightColor: AppColors.lightOrange,
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.rubik(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
