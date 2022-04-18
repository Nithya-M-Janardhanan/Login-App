import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import '../common/sharedpreferences.dart';

import '../services/db_helper.dart';

class ContactsProvider with ChangeNotifier {
  final DatabaseHelperDb _db = DatabaseHelperDb.instance;

  UsersList? _lists;
  String localityName='';

  UsersList? get lists => _lists;
   List<UserModel>?user;
  //
  set lists(UsersList? lists) {
    _lists = lists;
    notifyListeners();
  }

  Future<String?> _loadDataFromApi() async {
    //return await rootBundle.loadString('assets/$asset.json');
    return await ApiManager().getApiData();
  }

  Future<void> insertToUsers(UsersList? lists) async {
    if (lists?.userList != null && lists!.userList!.isNotEmpty) {
      lists.userList?.forEach((element) async {
        await _db.createUserList(element);
      });
    }
  }

  Future<void> loadUsers() async {
    //lists?.userList = await DatabaseHelperDb.instance.getUserList();
   user= await DatabaseHelperDb.instance.getUserList();
    //user = await ApiManager().getData();
   //lists?.userList = user;
   debugPrint('length ${user?.length}');
    if (user == null || user!.isEmpty) {
      String? jsonString = await _loadDataFromApi();
      final jsonResponse = json.decode(jsonString!);
      UsersList data = UsersList.fromJson(jsonResponse);
      data.userList?.forEach((element) async{
        await _db.createUserList(element);
      });
      user = await _db.getUserList();
      //user = UsersList.fromJson(jsonResponse);
      // if (user != null) {
      //   await insertToUsers(lists);
      // }
    }
    notifyListeners();
  }
  ///
  Future<void> loadContacts() async {
    lists?.userList = await DatabaseHelperDb.instance.getUserList();
    notifyListeners();
    debugPrint('length ${lists?.userList?.length}');
    if (lists?.userList == null) {
      String? jsonString = await _loadDataFromApi();
      final jsonResponse = json.decode(jsonString!);
      lists = UsersList.fromJson(jsonResponse);
      if (lists?.userList != null) {
        await insertToUsers(lists);
      }
    }
    notifyListeners();
  }
  ///set location name
    Future<void>setLocationName(String locationName) async{
      await SharedPreferenceHelper.setLocation(locationName);
      localityName = locationName;
      notifyListeners();
    }
  Future<void>getLocationName() async{
    await SharedPreferenceHelper.getLocation();
    notifyListeners();
  }
///
}