import 'dart:ui';

import 'package:buyer/viewmodel/auth_view_model.dart';

import 'package:buyer/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Auth Screens/sign_in_screen.dart';
import '../Auth Screens/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
        init: Get.find<AuthViewModel>(),
        builder: (controller) => Scaffold(
              body: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/welcome.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        )),
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'All food you want \nin one place',
                            style: GoogleFonts.rubik(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            'Enjoy around the different meals with \nbest prices',
                            style: GoogleFonts.rubik(
                                fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: filledButton(
                            buttonText: 'Get Started',
                            height: 50,
                            width: 100.w,
                            function: () {
                              Get.to(() => SignUpScreen(),
                                  duration: const Duration(milliseconds: 700),
                                  transition: Transition.zoom);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: outlineButton(
                            buttonText: 'Sign In',
                            buttonColor: Colors.white,
                            buttonTextColor: Colors.white,
                            height: 50,
                            width: 100.w,
                            function: () {
                              Get.to(() => SignInScreen(),
                                  duration: const Duration(
                                      milliseconds:
                                          700), //duration of transitions, default 1 sec
                                  transition: Transition.zoom);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
