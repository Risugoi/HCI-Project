import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class feeddb {
  feeddb.createInstance();

  static final dbName = "Feed.db";
  static final table1 = "Feed";

  Future<Database> createFeedTable() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create feed table
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table1(name, school, need, fundsCollected, fundsNeed)");
  }

  //insert content of the table
  Future<Database> insertFeed() async {
    String path = p.join(await getDatabasesPath(), dbName);
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
