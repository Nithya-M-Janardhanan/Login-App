import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_task/models/usermodel.dart';

import 'db.dart';
import 'db_helper.dart';

class ApiManager {

  static var jsonString;

  // Future<List<UserModel>> getData() async {
  //
  //   var client = http.Client();
  //
  //   var data;
  //   var a;
  //   try {
  //
  //     var response = await client
  //         .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
  //
  //     if (response.statusCode == 200) {
  //       //userModel= UserModel.fromJson(json.decode(response.body));
  //       jsonString = response.body;
  //       // var jsonMap = json.decode(jsonString);
  //       // userModel = UserModel.fromJson(jsonMap);
  //       // return userModelFromJson(jsonString);
  //       // debugPrint('>>>>>>>$userModel');
  //
  //        //data = userModelFromJson(jsonString);
  //      // UserModel a=UserModel.fromJson(jsonString);
  //      // print(jsonString);
  //     //  DbProvider.createUser(response.body as UserModel);
  //      //var user=userModelFromJson(jsonString);
  //        //DbProvider.createUser(user);
  //    //  print(user);//
  //    //   var users = await DbProvider.getAllUsers();
  //    //   print(users);
  //      //  a=  (response.body as List).map((users) {
  //     //     print('Inserting $users');
  //     //    // DbProvider.createUser(UserModel.fromJson(users));
  //     //
  //     //   }).toList();
  //
  //     }
  //   } catch (err) {
  //     debugPrint('$err');
  //   }
  //  // return a;
  //   return userModelFromJson(jsonString);
  // }
  ///
  Future<List<UserModel>> getData() async {
    var client = http.Client();
    var data;
    var a;
    try {
      var response = await client
          .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

      if (response.statusCode == 200) {
        jsonString = response.body;
        return userModelFromJson(jsonString);
       // DbHelper().save(jsonDecode(jsonString));
      }
    } catch (err) {
      debugPrint('$err');
    }
    return userModelFromJson(jsonString);
  }
  
  // Box? box;
  // Future openBox() async{
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box = await Hive.openBox('userBox');
  // }
  // Future<List<UserModel>> putData(UserModel userModel)async{
  //   box = await openBox();
  //   box!.add(userModel);
  //
  // }
  Future<List<UserModel?>> getDbData() async{
    final DatabaseHelperDb _db = DatabaseHelperDb.instance;
    UserModel userModel;
    var client = http.Client();
    List rejson;
    var response = await client
        .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
    if (response.statusCode == 200) {
      jsonString = response.body;
       rejson = jsonDecode(jsonString);
      //debugPrint('****************$rejson');
      // var map =rejson as Map;
       print(rejson.length);
       for(int i=0;i<rejson.length;i++){
         userModel = UserModel.fromJson(rejson[i]);
         // String map =rejson[i]['address']['street'];
         // debugPrint('****************$map');
         ///
        /* DbHelper().createUserList(userModel); */
        // _db.createUserList(userModel);
         ///
         //debugPrint('****************${rejson[i]['address']}');
       }



    }

    return userModelFromJson(jsonString);
  }

  Future<String?> getApiData() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

      if (response.statusCode == 200) {
        jsonString = response.body;
        return jsonString;
      }
    } catch (err) {
      debugPrint('$err');
    }

  }
}



