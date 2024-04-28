import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ustaxona/module/product_module.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "database.db"),
        onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE Product(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, dollor DOUBLE, sum DOUBLE, imagePath TEXT, createdAt TEXT)",
      );
    }, version: 1);
  }

  Future<int> createProduct(Product product) async {
    final Database db = await initializeDB();
    return await db.insert('Product', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
