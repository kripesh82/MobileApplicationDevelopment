import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _burgers =
  FirebaseFirestore.instance.collection('categories/1/burgers');

  final CollectionReference _pizza =
  FirebaseFirestore.instance.collection('categories/2/pizza');

  final CollectionReference _momo =
  FirebaseFirestore.instance.collection('categories/3/momo');

  final CollectionReference _chowmein =
  FirebaseFirestore.instance.collection('categories/4/chowmein');

  final CollectionReference _samosa =
  FirebaseFirestore.instance.collection('categories/5/samosa');

  final CollectionReference _beer =
  FirebaseFirestore.instance.collection('categories/6/beer');

  Future<List<QueryDocumentSnapshot>> getBurgerProducts() async {
    var value = await _burgers.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getPizzaProducts() async {
    var value = await _pizza.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getMomoProducts() async {
    var value = await _momo.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getChowmeinProducts() async {
    var value = await _chowmein.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getSamosaProducts() async {
    var value = await _samosa.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBeerProducts() async {
    var value = await _beer.get();
    return value.docs;
  }

  Future<List> getAllProducts() async {
    var allProducts = [];

    var value = await _burgers.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _pizza.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _momo.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _chowmein.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _samosa.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}
    value = await _beer.get();
    if (value.docs.isNotEmpty) {allProducts.addAll(value.docs);}

    return allProducts;
  }
}
