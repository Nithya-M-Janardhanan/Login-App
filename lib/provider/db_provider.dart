import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sample_task/machine_test/machine_api.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/services/api_manager.dart';
import '../common/const.dart';
import '../common/helpers.dart';
import '../common/sharedpreferences.dart';

import '../machine_test/homemodel.dart';
import '../services/db_helper.dart';

class ContactsProvider with ChangeNotifier {
  final DatabaseHelperDb _db = DatabaseHelperDb.instance;

  UsersList? _lists;

  UsersList? get lists => _lists;
  List<UserModel>? user;
  bool isLoading = false;
  LoadState pageLoadingState = LoadState.loaded;
  List<CartModel>? cartModel;
  List<FavouritesModel>? favList;
  int totalCartCount = 0;
  bool isFav = false;

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
    updatePageLoadingState(LoadState.loading);
    user = await DatabaseHelperDb.instance.getUserList();
    if (user == null || user!.isEmpty) {
      String? jsonString = await _loadDataFromApi();
      final jsonResponse = json.decode(jsonString!);
      UsersList data = UsersList.fromJson(jsonResponse);
      data.userList?.forEach((element) async {
        await _db.createUserList(element);
      });
      user = await _db.getUserList();
    }
    updatePageLoadingState(LoadState.loaded);
    notifyListeners();
  }

  ///
  Future<void> loadContacts() async {
    lists?.userList = await DatabaseHelperDb.instance.getUserList();
    notifyListeners();
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

  void updatePageLoadingState(LoadState val) {
    pageLoadingState = val;
    notifyListeners();
  }

  Future<void> insertProducts(Value value) async {
    await _db.createProductList(value);
    await loadProducts();
    Helpers.successToast('Product added to cart');
    notifyListeners();
  }
  Future<void> insertFavItems(Value value) async{
    await _db.createFavouritesList(value);
    await loadFavList();
    notifyListeners();
  }

  Future<void> loadProducts() async {
   cartModel= await DatabaseHelperDb.instance.getProduct();
   totalCartCount = 0;
   cartModel?.forEach((element) {
     if(element.count != null){
       totalCartCount = totalCartCount + element.count!.toInt();
     }
   });
    notifyListeners();
  }
  Future<void> loadFavList() async{
    favList = await DatabaseHelperDb.instance.getFavoritesList();
    notifyListeners();
  }

Future<void>deleteAllData()async{
    await DatabaseHelperDb.instance.deleteAllData();
    await loadProducts();
    totalCartCount = 0;
   // await DatabaseHelperDb.instance.getProduct();
    notifyListeners();
}
Future<void> deleteData(int? id)async{
    await DatabaseHelperDb.instance.deleteData(id);
    await loadProducts();
    notifyListeners();
}
  Future<void> deleteFavouritesItem(int? id)async{
    isFav = false;
    await DatabaseHelperDb.instance.deleteFavItem(id);
    await loadFavList();
    notifyListeners();
  }
Future<void> updateCountfn(int? id,int? count) async{
    await DatabaseHelperDb.instance.updateCount(id, count);
    await loadProducts();
    notifyListeners();
}

}
