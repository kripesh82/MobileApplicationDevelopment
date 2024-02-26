import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final CollectionReference _categoryColRef =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference _bestColRef =
      FirebaseFirestore.instance.collection('bestselleing');

  Future<List<QueryDocumentSnapshot>> getCategory() async {
    var value = await _categoryColRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBestSelling() async {
    var value = await _bestColRef.get();
    return value.docs;
  }

  Future<List<String>> getBanners() async {
    List<String> bannerList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('banners').get();

    for (var doc in querySnapshot.docs) {
      String bannerLink = doc['banner'];
      bannerList.add(bannerLink);
    }

    return bannerList;
  }
}
