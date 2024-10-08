import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zawiid/model/Product/Products.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'search_history.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE SearchHistory(id INTEGER PRIMARY KEY, productNo INTEGER, productName TEXT, price TEXT, productImage TEXT)',
        );
      },
    );
  }

  Future<void> clearSearchHistory() async {
    Database db = await database;
    await db.delete('SearchHistory');
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'SearchHistory',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getSearchHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('SearchHistory');

    return List.generate(maps.length, (i) {
      return Product(
        productNo: maps[i]['productNo'],
        productName: maps[i]['productName'],
        productDesc: '', // default empty string
        price: maps[i]['price'],
        subCategoryNo: 0, // default value
        markNo: 0, // default value
        size: '', // default empty string
        colorNo: 0, // default value
        discountedPrice: '0.0', // default value
        isOpenBox: 0, // default value
        productImage: maps[i]['productImage'],
      );
    });
  }
}
