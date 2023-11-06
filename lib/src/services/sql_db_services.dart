import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SqlDBService {
  SqlDBService._();
  static final SqlDBService sqlDBServiceinstance = SqlDBService._();
  static Database? _database;
  factory SqlDBService() => sqlDBServiceinstance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    return await openDatabase(
      'bikerr_partner_db',
      version: 20,
      onCreate: (Database database, int version) async {
        return await _createTables(database);
      },
    );
  }

  Future<void> _createTables(Database database) async {
    await database.execute("""CREATE TABLE UserDetails(
        id INTEGER PRIMARY KEY NULL,
        user_id TEXT,
        user_name TEXT,
        user_email TEXT,
        user_number TEXT,
        user_image TEXT
      )
      """);
  }

  Future clearDb() async {
    Database database = SqlDBService._database!;
    try {
      await database.delete("UserDetails");
    } catch (e) {
      log("$e");
    }
  }

  Future insertUserDetails({
    required int id,
    required String userId,
    required String userName,
    required String email,
    required String mobileNumber,
    required String image,
  }) async {
    Database database = SqlDBService._database!;
    final data = {
      "id": id,
      "user_id": userId,
      "user_name": userName,
      "user_email": email,
      "user_number": mobileNumber,
      "user_image": image,
    };
    return await database.insert(
      'UserDetails',
      data,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future updateUserDetails({
    required int id,
    required String userId,
    required String userName,
    required String email,
    required String mobileNumber,
    required String image,
  }) async {
    Database database = SqlDBService._database!;
    final data = {
      "id": id,
      "user_id": userId,
      "user_name": userName,
      "user_email": email,
      "user_number": mobileNumber,
      "user_image": image,
    };
    return await database
        .update('UserDetails', data, where: "id = ?", whereArgs: [id]);
  }

  Future getUserDetails() async {
    Database database = SqlDBService._database!;
    return await database.query(
      'UserDetails',
      orderBy: "id",
    );
  }
}
