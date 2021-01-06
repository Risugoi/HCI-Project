import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class dbHelper {
  dbHelper.createInstance();

  static final dbName = "Database.db";
  static final table1 = "Register";

  //columns inside the table
  static final username = "username";
  static final school = "school";
  static final year = "year";
  static final email = "email";
  static final password = "password";
  static final name = "name";

//create login table
  Future<Database> createSignupTable() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table1(username, name, school, year, email, password)");
  }

//signup
  Future<Database> insertInfo() async {
    String path = p.join(await getDatabasesPath(), dbName);
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
