import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import 'package:sqflite/sqflite.dart';

// class DbHelper{
//   static Database? _db;
//    static const String TABLE = 'users';
//   static const String ID = 'id';
//   /*static const String NAME = 'name';
//   static const String USERNAME = 'username';
//   static const String EMAIL = 'email';
//   static const String PROFILEIMAGE = 'profile_image';
//   static const String ADDRESS = 'address';
//   static  String STREET = 'street';
//   static const String PHONE = 'phone';
//   static const String WEBSITE = 'website';
//   static const String COMPANY = 'company';*/
//   static const String DB_NAME = 'users.db';
//   static const USER = 'user';
//
//   Future<Database?> get db async{
//     if(_db != null){
//       return _db;
//     }else{
//       _db = await initDb();
//       return _db;
//     }
//   }
//   initDb() async{
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path,DB_NAME);
//     var db = await openDatabase(path,version: 1,onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db,int version) async{
//     //await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY,$NAME TEXT,$USERNAME TEXT,$EMAIL TEXT,$PROFILEIMAGE TEXT,$STREET TEXT,$PHONE TEXT,$WEBSITE TEXT,$COMPANY TEXT)");
//       await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY,$USER TEXT)");
//   }
//
//   // Future<UserModel> save(UserModel userModel) async{
//   //    UserModel user = await ApiManager().getDbData() as UserModel;
//   //   // print(user);
//   //   var dbClient = await db;
//   //   final res = await dbClient!.insert(TABLE, userModel.toJson(),);
//   //   print(res);
//   //   return user;
//
//  /* Future<List<UserModel>> getAll() async{
//    await ApiManager().getDbData();
//     //await save();
//     var dbClient = await db;
//     List<Map<String,dynamic>> maps = await dbClient!.query(TABLE,columns: [ID,NAME,USERNAME,EMAIL,PROFILEIMAGE,STREET,PHONE,WEBSITE,COMPANY]);
//     List<UserModel> userList =[];
//     if(maps.length > 0){
//       for(int i = 0;i < maps.length; i++){
//         userList.add(UserModel.fromJson(maps[i]));
//       }
//     }else{
//       print('0000000000000000.....map is null');
//     }
//     return userList;
//   } */
//   createUserList(UserModel user) async{
//     var userValue = user.toJson();
//     String jsonString = jsonEncode(userValue);
//     debugPrint('!!!!!!!!!!!!!!!!!$jsonString');
//     Map<String,dynamic> insertVal = {USER : jsonString};
//     var dbClient = await db;
//     final result = await dbClient?.insert(TABLE, insertVal,conflictAlgorithm: ConflictAlgorithm.replace);
//     return result;
//   }
//   Future<List<UserModel>> getUserList()async{
//     await ApiManager().getDbData();
//     var dbClient = await db;
//     List<Map<String,dynamic>> res = await dbClient!.query(TABLE);
//     // List<UserModel> list =
//     // res!.isNotEmpty ? res.map((c) => UserModel.fromJson(c)).toList() : [];
//     ///
//     //return list;
//     return List.generate(res.length, (index) => UserModel.fromJson(jsonDecode(res[index][USER])));
//
//   }
//   Future<int?> deleteDb() async{
//     var dbClient = await db;
//     final res = await dbClient?.rawDelete('DELETE FROM $TABLE');
//     debugPrint('-------------$res');
//     return res;
//   }
//   Future<int?> getCount()async{
//     // data=await openDatabase(DbHelper.DB_NAME);
//     // count=Sqflite.firstIntValue(await data.rawQuery('SELECT COUNT * FROM $TABLE'));
//      var dbClient = await db;
//     // final res = (await dbClient?.rawQuery('SELECT COUNT (*) FROM $TABLE'));
//     //count = Sqflite.firstIntValue(await dbClient!.rawQuery('SELECT COUNT(*) FROM table_name'));
//      var x = await dbClient!.rawQuery('SELECT COUNT (*) from $TABLE');
//          int? count = Sqflite.firstIntValue(x);
//     print('count..........$count');
//     return 10;
//   }
//   // Future close() async {
//   //   final _db = await DbHelper().db;
//   //   _db?.close();
//   // }
// }
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
    // List<UserModel> list =
    // res!.isNotEmpty ? res.map((c) => UserModel.fromJson(c)).toList() : [];
    ///
    //return list;
    return List.generate(res.length, (index) => UserModel.fromJson(jsonDecode(res[index][USER])));

  }

  testfn(){
    debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }
}