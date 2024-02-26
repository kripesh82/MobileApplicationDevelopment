import 'dart:convert';

import 'package:buyer/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleDatabaseHelper extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await getUserSP();
      return userModel;
    } catch (e) {
      return null;
    }
  }

  setUserSP(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', json.encode(userModel.toJson()));
  }

  getUserSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString('user');
    return UserModel.fromJson(json.decode(user!));
  }

  deleteUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
