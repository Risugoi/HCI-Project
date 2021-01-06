import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class requestdb {
  requestdb.createInstance();
  //table name
  static final table = "Request";

  //columns inside the table
  static final name = "name";
  static final school = "school";
  static final year = "year";
  static final need = "need";
  static final fundsCollected = "fundsCollected";
  static final fundsNeed = "fundsNeed";
  static final message = "message";
  static final location = "location";

  Future<Database> insertRequest(String username) async {
    String path = p.join(await getDatabasesPath(), '$username.db');
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
