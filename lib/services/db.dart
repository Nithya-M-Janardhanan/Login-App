
/*import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider{
  static Database? _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  initDB()async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,'user_details.db');

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db,int version) async{
          await db.execute(
              // 'CREATE TABLE Users('
              // 'id INTEGER PRIMARY KEY,'
              // 'email TEXT,'
              // 'name TEXT,'
              // 'username TEXT,'
              // 'image TEXT,'
              // ')'
            'CREATE TABLE Users(id INTEGER PRIMARY KEY,email TEXT,name TEXT,username TEXT,image TEXT)'
          );
        });
  }

  createUser(UserModel userModel) async{
    // await deleteAllUsers();
     final db = await database;
    // final res = await db!.rawInsert('Users',userModel.toJson());
    //
    // return res;
    return await db!.insert('Users', userModel.toJson());
  }

  Future<int> deleteAllUsers() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Users');

    return res;
  }

  Future<List<UserModel>?> getAllUsers() async {
    final db = await database;
    // final res = await db!.rawQuery("SELECT * FROM USERS");
    //
    // List<UserModel> list =
    // res.isNotEmpty ? res.map((c) => UserModel.fromJson(c)).toList() : [];
    //
    // return list;
    final res = await db!.query('Users');
    List<UserModel> list = res.isNotEmpty ? res.map((details) => UserModel.fromJson(details)).toList() : [];
    return list;
  }
}
/*class DbProvider{

 static Future<Database> initDB()async{
    var dbPath = await getDatabasesPath();
    String path = join(dbPath,'user.db');
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  static Future _onCreate(Database db,int version) async{
    final sql = '''CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    email TEXT,
    name TEXT,
    username TEXT,
    phone TEXT,
    website TEXT
    )''';
    await db.execute(sql);

  }

  static Future<int>createUser(List<UserModel> userModel) async{

    Database db = await DbProvider.initDB();

    return  await db.insert('users', userModel[1].toJson(),);
  }

  static Future<int> deleteAllUsers() async {
    Database db = await DbProvider.initDB();
    final res = await db.rawDelete('DELETE FROM Users');

    return res;
  }

  static Future<List<UserModel>?> getAllUsers() async {
    //await ApiManager().getData();
    Database db = await DbProvider.initDB();
    var res = await db.query('users');
    debugPrint('!!!!!!!!!!!!!!!!$res');
    List<UserModel> list = res.isNotEmpty ? res.map((details) => UserModel.fromJson(details)).toList() : [];
    //List<UserModel> list = res.isNotEmpty ? await ApiManager().getData() : [];
    return list;
  }
}*/
*/