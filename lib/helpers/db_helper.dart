import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
   return openDatabase(path.join(dbPath, 'memes.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE memes(id TEXT PRIMARY KEY, description TEXT, image TEXT)');
        }, version: 1);
  }

  static Future<void> insert(Map<String, Object> data) async {
    final database = await DBHelper.database();
    await database.insert(
      'memes',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final database = await DBHelper.database();
    return database.query('memes');
  }

  static Future<void> remove(String id) async {
    final database = await DBHelper.database();
    database.delete('memes', where: "id = ?", whereArgs: [id]);
  }
}
