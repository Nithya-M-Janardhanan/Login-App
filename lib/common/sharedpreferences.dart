import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  //static SharedPreferences _preferences ;
  static const _keyUsername = 'username';
  static const String login = 'loginMethod';
  static const String sensorVal ='val';
  static const String locationVal ='loc';
  // static Future init() async{
  //   _preferences = await SharedPreferences.getInstance();
  // }

  static Future setUsername(String username) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.setString(_keyUsername, username);
  }

   static Future<String> getUsername() async{
    String name ='';
    SharedPreferences _preferences =  await SharedPreferences.getInstance();
   name = _preferences.getString(_keyUsername)??'';
   debugPrint('name is.........$name');
   return name;
  }
  static Future<void> removeUser()async{
    SharedPreferences _preferences =  await SharedPreferences.getInstance();
    _preferences.remove(_keyUsername);
    debugPrint(' key name is.........$_keyUsername');
  }
  static Future<void> saveLoginMethod(String method) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(login, method);
  }
  static Future<String?> getLoginMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginType = prefs.getString(login);
    return loginType;
  }
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(login);
    await prefs.remove(_keyUsername);
    await prefs.remove(sensorVal);
    debugPrint("Cleared Data");
  }
  static Future<void> setSensor(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sensorVal, status);
  }

  static Future<bool> getSensor() async {
    bool val = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(sensorVal)) {
      val = prefs.getBool(sensorVal)!;
    }
    return val;
  }
  static Future setLocation(String location) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.setString(locationVal, location);
  }

  static Future<String> getLocation() async{
    String locationName ='';
    SharedPreferences _preferences =  await SharedPreferences.getInstance();
    locationName = _preferences.getString(locationVal)??'';
    debugPrint('location name is.........$locationName');
    return locationName;
  }

}