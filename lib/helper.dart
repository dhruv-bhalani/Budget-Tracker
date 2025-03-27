import 'package:budget_tracker/model/category_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../model/spending_model.dart';

class DBHelper {
  DBHelper._();
  static Logger logger = Logger();
  static DBHelper dbHelper = DBHelper._();
  //  categoryTables
  String categoryTable = 'category';
  String categoryName = 'categoryName';
  String categoryImage = 'categoryImage';
  String categoryID = 'categoryID';
  String categoryImageIndex = 'categoryImageIndex';
  // spendingTables
  String spendingTable = 'spending';
  String spendingName = 'spendingName';
  String spendingAmount = 'spendingAmount';
  String spendingDate = 'spendingDate';
  String spendingMode = 'spendingMode';
  String spendingImage = 'spendingImage';
  String spendingID = 'spendingID';
  String spendingCategoryID = 'spendingCategoryID';
  String spendingTime = 'spendingTime';

  Database? db;
  // initDB
  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      '${path}budget.db',
      version: 1,
      onCreate: (db, version) async {
        String query = '''CREATE TABLE $categoryTable (
              $categoryID INTEGER PRIMARY KEY AUTOINCREMENT,
              $categoryImageIndex INTEGER NOT NULL,
              $categoryName TEXT NOT NULL,
              $categoryImage TEXT NOT NULL
             );''';
        await db.execute(query);

        String query2 = '''CREATE TABLE $spendingTable (
        $spendingID INTEGER PRIMARY KEY AUTOINCREMENT,
        $spendingName TEXT NOT NULL,
        $spendingAmount NUMERIC NOT NULL,
        $spendingMode TEXT NOT NULL,
        $spendingDate TEXT,
        $spendingTime TEXT,
        $spendingImage TEXT NOT NULL
         );''';
        await db.execute(query2);
      },
    );
  }

  // insertCategoryData
  Future<int?> insertCategoryData(
      {required name, required image, required imageIndex}) async {
    await initDB();
    String query =
        "INSERT INTO $categoryTable ($categoryName, $categoryImage,$categoryImageIndex) VALUES (?,?,?);";
    List args = [name, image, imageIndex];
    return db?.rawInsert(query, args);
  }

  Future<int?> insertSpendingData(SpendingModel model) async {
    await initDB();
    String query =
        "INSERT INTO $spendingTable ($spendingName, $spendingAmount,$spendingMode,$spendingDate,$spendingTime,$spendingImage) VALUES (?,?,?,?,?,?);";
    List args = [
      model.name,
      model.amount,
      model.mode,
      model.date,
      model.time,
      model.image
    ];
    return await db?.rawInsert(query, args);
  }

  // fetchCategoryData
  Future<List<CategoryModel>> fetchCategoryData() async {
    await initDB();
    String query = "SELECT * FROM $categoryTable";
    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    return data.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<List<SpendingModel>> fetchSpendingData() async {
    await initDB();
    String query = "SELECT * FROM $spendingTable";
    List<Map<String, dynamic>> data = await db?.rawQuery(query) ?? [];

    return data.map((e) => SpendingModel.fromJson(e)).toList();
  }

  // searchCategoryData
  Future<List<CategoryModel>> searchCategoryData(String search) async {
    await initDB();

    String query =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%';";
    List<Map<String, dynamic>> result = await db?.rawQuery(query) ?? [];
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  // deleteCategoryData
  Future<int?> deleteCategoryData(int id) async {
    await initDB();
    String query = "DELETE FROM $categoryTable WHERE $categoryID = $id";
    return await db?.rawDelete(query);
  }
  //  spending Data delete

  Future<int?> deleteSpendingData(int id) async {
    await initDB();
    String query = "DELETE FROM $spendingTable WHERE $spendingID = $id";
    return await db?.rawDelete(query);
  }

  //  editCategoryData
  Future<int?> editCategoryData(CategoryModel model) async {
    await initDB();

    String query =
        "UPDATE $categoryTable SET $categoryName = ?,$categoryImageIndex = ?,$categoryImage = ? WHERE $categoryID = ${model.id};";
    List args = [
      model.name,
      model.imageIndex,
      model.image,
    ];
    return await db?.rawUpdate(query, args);
  }
}
