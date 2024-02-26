import 'package:buyer/constants/colors.dart';
import 'package:buyer/view/Auth%20Screens/sign_up_screen.dart';
import 'package:buyer/viewmodel/auth_view_model.dart';

import 'package:buyer/widgets/buttons.dart';
import 'package:buyer/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends GetWidget<AuthViewModel> {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          icon: const Icon(
            Ionicons.chevron_back,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.orange),
        centerTitle: true,
        title: const Text(
          'Sign In',
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
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
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
                      'Welcome Again!',
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
                      'Sign In with your email and password \nor continue with Google',
                      style: GoogleFonts.rubik(
                          fontSize: 11.sp, color: AppColors.lightGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  textField(
                    width: 100.w,
                    textType: TextInputType.emailAddress,
                    iconLead: Ionicons.mail_outline,
                    iconSize: 28,
                    hintText: 'kripesh@gmail.com',
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
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      highlightColor: AppColors.lightOrange,
                      child: Text(
                        'Forget Password?',
                        style: GoogleFonts.rubik(
                          fontSize: 11.sp,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  filledButton(
                    buttonText: 'Sign In',
                    height: 50,
                    width: 100.w,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.emailAndPassSignIn();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or you can sign in with',
                      style: GoogleFonts.rubik(
                          fontSize: 11.sp, color: AppColors.lightGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                    heroTag: 'fab2',
                    onPressed: () async {
                      controller.googleSignIn();
                    },
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/google.png',
                      height: 4.h,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Not have an account yet?',
                        style: GoogleFonts.rubik(
                            fontSize: 11.sp, color: AppColors.lightGrey),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => SignUpScreen(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.zoom);
                        },
                        highlightColor: AppColors.lightOrange,
                        child: Text(
                          'Register Now',
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
        ],
      ),
    );
  }
}
