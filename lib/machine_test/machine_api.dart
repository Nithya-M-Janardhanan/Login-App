import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

import 'homemodel.dart';

class ApiServices{
  Future<HomeModel?> getData()async{
    var client = http.Client();
    try{
      var response =await client.get(Uri.parse('https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0'));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var rejson = jsonDecode(jsonString);
        return HomeModel.fromJson(rejson);
      }
    }catch(err){
      debugPrint('>>>>>>>>>>>>>$err');
    }
  }
  Future<String?> getDataDb()async{
    var client = http.Client();
    try{
      var response =await client.get(Uri.parse('https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0'));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var rejson = jsonDecode(jsonString);
        return jsonString;
      }
    }catch(err){
      debugPrint('>>>>>>>>>>>>>$err');
    }
  }
}