import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _tShirts =
      FirebaseFirestore.instance.collection('categories/1/tshirts');

  final CollectionReference _trousers =
      FirebaseFirestore.instance.collection('categories/2/trousers');

  final CollectionReference _shoes =
      FirebaseFirestore.instance.collection('categories/3/shoes');

  final CollectionReference _socks =
      FirebaseFirestore.instance.collection('categories/4/socks');

  final CollectionReference _sunglasses =
      FirebaseFirestore.instance.collection('categories/5/sunglasses');

  final CollectionReference _watches =
      FirebaseFirestore.instance.collection('categories/6/watches');

  Future<List<QueryDocumentSnapshot>> getTshirtProducts() async {
    var value = await _tShirts.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getTrouserProducts() async {
    var value = await _trousers.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getShoesProducts() async {
    var value = await _shoes.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getSocksProducts() async {
    var value = await _socks.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getSunProducts() async {
    var value = await _sunglasses.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getWatchProducts() async {
    var value = await _watches.get();
    return value.docs;
  }

  Future<List> getAllProducts() async {
    var allProducts = [];

    var value = await _tShirts.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _trousers.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _shoes.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _socks.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _sunglasses.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _watches.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}

    return allProducts;
  }
}
