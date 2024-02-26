// ignore_for_file: avoid_print, unnecessary_overrides

import 'dart:io';

import 'package:buyer/constants/colors.dart';
import 'package:buyer/model/user_model.dart';
import 'package:buyer/utils/database/local_database_helper.dart';
import 'package:buyer/view/Home%20Screens/controll_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sizer/sizer.dart';

import '../utils/services/firestore_user.dart';

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isVisible = false.obs;

  String? email, password, passwordConfirm, name;

  final Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  File? imageFile;

  String? _newImage;

  String? get newImage => _newImage;

  SimpleFontelicoProgressDialog? prograssDialog =
      SimpleFontelicoProgressDialog(context: Get.context!);

  final LocaleDatabaseHelper localeDatabaseHelper = LocaleDatabaseHelper();

  void toggleObscure() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser!.uid);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!.show(
        message: "Loading...",
        indicatorColor: AppColors.orange,
        textStyle: TextStyle(color: Colors.black, fontSize: 12.sp));
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  void googleSignIn() async {
    GoogleSignInAccount? googleAccount;
    try {
      showPrograssDialog();
      try {
        googleAccount =
            await _googleSignIn.signIn().catchError((onError) => null);
      } catch (e) {
        hidePrograssDialog();
        Get.snackbar('Error with Sign In !', e.toString(),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }

      if (googleAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        try {
          await _auth
              .signInWithCredential(credential)
              .then((user) => saveUser(user));
        } catch (e) {
          hidePrograssDialog();
          Get.snackbar('Error with Sign In !', e.toString(),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      }

      hidePrograssDialog();
      Get.offAll(() =>  const ControllScreen(),
          duration: const Duration(milliseconds: 700),
          transition: Transition.zoom);
    } catch (e) {
      print(e.toString());
      hidePrograssDialog();
      Get.snackbar('Error with Sign In !', e.toString(),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void emailAndPassSignIn() async {
    try {
      showPrograssDialog();
      await _auth
          .signInWithEmailAndPassword(
              email: email ?? "xxx", password: password ?? "xxx")
          .then((value) async {
        getCurrentUserData(value.user!.uid);
      });
      hidePrograssDialog();
      Get.offAll(() =>  const ControllScreen(),
          duration: const Duration(milliseconds: 700),
          transition: Transition.zoom);
    } catch (e) {
      print(e.toString());
      hidePrograssDialog();
      Get.snackbar('Error with Sign In !', e.toString(),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void emailAndPassSignUp() async {
    try {
      showPrograssDialog();
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) => saveUser(user));
      hidePrograssDialog();
      Get.offAll(() =>  const ControllScreen(),
          duration: const Duration(milliseconds: 700),
          transition: Transition.zoom);
    } catch (e) {
      print(e.toString());
      hidePrograssDialog();
      Get.snackbar('Error with Sign In !', e.toString(),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
        userId: user.user!.uid,
        name: name ?? user.user?.displayName,
        email: user.user!.email,
        pic: user.user!.photoURL ??
            'https://firebasestorage.googleapis.com/v0/b/buyer-51b4d.appspot.com/o/user.png?alt=media&token=cec22366-4664-4e69-b474-83280b3bff8c');
    await FireStoreUser().addUserToFireStore(userModel);
    setUser(userModel);
  }

  void setUser(UserModel userModel) async {
    localeDatabaseHelper.setUserSP(userModel);
  }

  void getCurrentUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
    });
  }

  void updateCurrentUserData(UserModel userModel) async {
    await FireStoreUser()
        .updateUser(userModel.userId!, userModel.name!, userModel.pic!,
            userModel.email!)
        .then((value) {
      setUser(userModel);
    });
    update();
  }

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      Get.snackbar('Process Faild', 'There is no image selected.',
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  UploadTask? uploadImage(File image, String fileName) {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(image);
      update();
      return uploadTask;
    } catch (e) {
      Get.snackbar('Process Faild', 'Failed to update your profile.',
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
    return null;
  }
}
