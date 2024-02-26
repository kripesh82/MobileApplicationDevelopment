import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/colors.dart';

class ThemeService {
  final _getStorage = GetStorage();

  final _darkThemeKey = 'isDarkTheme';

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.orange,
    primarySwatch: orangeMaterial,
  );

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.orange,
    primarySwatch: orangeMaterial,
  );

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}

Map<int, Color> mainColor = {
  50: const Color.fromRGBO(255, 96, 0, .1),
  100: const Color.fromRGBO(255, 96, 0, .2),
  200: const Color.fromRGBO(255, 96, 0, .3),
  300: const Color.fromRGBO(255, 96, 0, .4),
  400: const Color.fromRGBO(255, 96, 0, .5),
  500: const Color.fromRGBO(255, 96, 0, .6),
  600: const Color.fromRGBO(255, 96, 0, .7),
  700: const Color.fromRGBO(255, 96, 0, .8),
  800: const Color.fromRGBO(255, 96, 0, .9),
  900: const Color.fromRGBO(255, 96, 0, 1),
};
MaterialColor orangeMaterial = MaterialColor(0xFFFF6000, mainColor);
