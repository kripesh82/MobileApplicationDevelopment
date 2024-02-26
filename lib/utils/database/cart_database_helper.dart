import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/cart_product_model.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();

  static final CartDatabaseHelper db = CartDatabaseHelper._();

  final String tableCartProduct = 'cartProduct';
  final String columnName = 'name';
  final String columnImage = 'image';
  final String columnQuan = 'quantity';
  final String columnPrice = 'price';
  final String columnId = 'productId';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $tableCartProduct (
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnQuan INTEGER NOT NULL,
        $columnId TEXT NOT NULL
      )
       ''');
    });
  }

  insert(CartProductModel model) async {
    var dbClient = await database;
    await dbClient?.insert(tableCartProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartProductModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query(tableCartProduct);
    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];

    return list;
  }

  updateProduct(CartProductModel model) async {
    var dbClient = await database;
    return await dbClient!.update(tableCartProduct, model.toJson(),
        where: '$columnId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(CartProductModel model) async {
    var dbClient = await database;
    return await dbClient!.delete(tableCartProduct,where: '$columnId = ?',
      whereArgs: [model.productId] );
  }

  deleteAllProduct() async {
    var dbClient = await database;
    return await dbClient!.delete(tableCartProduct);
  }
}
