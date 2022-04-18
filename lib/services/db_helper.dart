import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelperDb{
  static Database? _db;
  DatabaseHelperDb._internal();
  static final DatabaseHelperDb instance = DatabaseHelperDb._internal();
  static const String TABLE = 'users';
  static const String ID = 'id';
  static const String DB_NAME = 'users.db';
  static const USER = 'user';

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }
  initDb() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,DB_NAME);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db,int version) async{
    //await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY,$NAME TEXT,$USERNAME TEXT,$EMAIL TEXT,$PROFILEIMAGE TEXT,$STREET TEXT,$PHONE TEXT,$WEBSITE TEXT,$COMPANY TEXT)");
    await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY,$USER TEXT)");
  }
  createUserList(UserModel user) async{
    var userValue = user.toJson();
    String jsonString = jsonEncode(userValue);
    debugPrint('!!!!!!!!!!!!!!!!!$jsonString');
    Map<String,dynamic> insertVal = {USER : jsonString};
    var dbClient = await db;
    final result = await dbClient?.insert(TABLE, insertVal,conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }
  Future<List<UserModel>> getUserList()async{
    debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    await ApiManager().getDbData();
    var dbClient = await db;
    List<Map<String,dynamic>> res = await dbClient!.query(TABLE);
    return List.generate(res.length, (index) => UserModel.fromJson(jsonDecode(res[index][USER])));

  }


}