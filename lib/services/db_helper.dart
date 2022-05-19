import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import 'package:sqflite/sqflite.dart';
import '../machine_test/homemodel.dart';


class DatabaseHelperDb{
  static Database? _db;
  DatabaseHelperDb._internal();
  static final DatabaseHelperDb instance = DatabaseHelperDb._internal();
  static const String TABLE = 'users';
  static const String ID = 'id';
  static const String DB_NAME = 'users.db';
  static const USER = 'user';
  static const String CARTTABLE = 'cart';
  static const String CARTID = 'cartid';
  static const CARTLIST = 'cartlist';
  static const COUNT = 'count';
  static const String FAVOURITESTABLE = 'favourites';
  static const String FAVID = 'favid';
  static const FAVLIST = 'favlist';
  int? itemCount;
  CartModel? cartModel;
  var productValue;
  var productCountValue;
  var favouritesValue;
  int? pCount;

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
    await db.execute("CREATE TABLE $CARTTABLE($CARTID INTEGER PRIMARY KEY,$CARTLIST TEXT,$COUNT INTEGER)");
    await db.execute("CREATE TABLE $FAVOURITESTABLE($FAVID INTEGER PRIMARY KEY,$FAVLIST TEXT)");
  }
  createUserList(UserModel user) async{
    var userValue = user.toJson();
    String jsonString = jsonEncode(userValue);
    Map<String,dynamic> insertVal = {USER : jsonString};
    var dbClient = await db;
    final result = await dbClient?.insert(TABLE, insertVal,conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }
  Future<List<UserModel>> getUserList()async{
    await ApiManager().getDbData();
    var dbClient = await db;
    List<Map<String,dynamic>> res = await dbClient!.query(TABLE);
    return List.generate(res.length, (index) => UserModel.fromJson(jsonDecode(res[index][USER])));

  }

  createProductList(Value value) async{
    var dbClient = await db;
     productValue = value.toJson();
    String jsonString = jsonEncode(productValue);
    List<CartModel>? getList = await getProduct();
    final check = getList?.firstWhere((element) => element.value?.id == value.id,orElse: ()=>CartModel());
    if( check?.value != null){
     int? count = check?.count ?? 0;
     count = count + 1;
     await updateCount(check?.id, count);
    }else{
      Map<String,dynamic> insertVal = {CARTLIST : jsonString,COUNT:1};
      final result = await dbClient?.insert(CARTTABLE, insertVal,conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    }

  }
  createFavouritesList(Value value) async{
    var dbClient = await db;
    favouritesValue = value.toJson();
    String jsonString = jsonEncode(favouritesValue);
    List<FavouritesModel>? getFavList = await getFavoritesList();
     final check = getFavList?.firstWhere((element) => element.favourites?.id == value.id,orElse: ()=>FavouritesModel());
    // if( check?.value != null){
    //   int? count = check?.count ?? 0;
    //   count = count + 1;
    //   await updateCount(check?.id, count);
    // }else{
      Map<String,dynamic> insertVal = {FAVLIST : jsonString};
      final result = await dbClient?.insert(FAVOURITESTABLE, insertVal,conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    // }

  }
  Future<List<CartModel>?> getProduct()async{
    var dbClient = await db;
    List<Map<String,dynamic>>? res = await dbClient?.query(CARTTABLE);
     final result = res?.map((e) => CartModel.fromJson(e)).toList() ;
      return result;
  }
  Future<List<FavouritesModel>?> getFavoritesList()async{
    var dbClient = await db;
    List<Map<String,dynamic>>? res = await dbClient?.query(FAVOURITESTABLE);
    debugPrint('>>>>>>> response>>>> $res');
    final result = res?.map((e) => FavouritesModel.fromJson(e)).toList() ;
    return result;
  }

  Future<void> deleteAllData()async{
  var dbClient = await db;
  await dbClient?.delete(CARTTABLE);
}

Future<void>deleteData(int? id)async{
  var dbClient = await db;
  await dbClient?.delete(CARTTABLE,where: '$CARTID = ?',whereArgs: [id]);
}
  Future<void>deleteFavItem(int? id)async{
    var dbClient = await db;
    await dbClient?.delete(FAVOURITESTABLE,where: '$FAVID = ?',whereArgs: [id]);
  }
Future<void> updateCount(int? id,int? count)async{
    var dbClient = await db;
    await dbClient?.rawUpdate('UPDATE $CARTTABLE SET $COUNT = $count WHERE $CARTID = $id');
}
}