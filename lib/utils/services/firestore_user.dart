import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");


  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Future<DocumentSnapshot> getCurrentUser(String userId) async {
    return await _userCollectionRef.doc(userId).get();
  }

  Future<void> updateUser(
      String userId, String newName, String newPic, String newEmail) async {
    await _userCollectionRef
        .doc(userId)
        .update({'name': newName, 'pic': newPic, 'email': newEmail});
  }
}
