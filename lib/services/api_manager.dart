import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sample_task/models/usermodel.dart';
import 'db_helper.dart';

class ApiManager {
  static var jsonString;

  Future<List<UserModel>?> getData() async {
    var client = http.Client();
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
    // return userModelFromJson(jsonString);
  }

  Future<List<UserModel?>> getDbData() async {
    final DatabaseHelperDb _db = DatabaseHelperDb.instance;
    UserModel userModel;
    var client = http.Client();
    List rejson;
    try {
      var response = await client
          .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
      if (response.statusCode == 200) {
        jsonString = response.body;
        rejson = jsonDecode(jsonString);
        for (int i = 0; i < rejson.length; i++) {
          userModel = UserModel.fromJson(rejson[i]);
        }
      }
    } catch (err) {
      debugPrint('$err');
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
