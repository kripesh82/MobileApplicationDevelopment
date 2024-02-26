import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:buyer/utils/Dependency%20Injection/binding.dart';
import 'package:buyer/utils/services/theme_service.dart';
import 'package:buyer/view/Home%20Screens/controll_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'constants/colors.dart';
import 'viewmodel/cart_view_model.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.orange,
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(CartViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Foodly",
        initialBinding: Binding(),
        home: AnimatedSplashScreen(
          nextScreen: const Scaffold(
            body: ControllScreen(),
          ),
          splash: Text(
            'Foodly',
            style: GoogleFonts.rubik(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          duration: 900,
          backgroundColor: const Color.fromARGB(255, 255, 102, 0),
          splashTransition: SplashTransition.fadeTransition,
        ),
        theme: ThemeService().lightTheme,
        darkTheme: ThemeService().darkTheme,
        themeMode: ThemeService().getThemeMode(),
      );
    });
  }
}
