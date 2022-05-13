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
  List<HomeModel>? homeData;
  // List<Value>? val;
  List<CartModel>? cartModel;

  // List<String>? products;
  HomeModelList? _products;

  HomeModelList? get products => _products;

  //
  set lists(UsersList? lists) {
    _lists = lists;
    notifyListeners();
  }

  set products(HomeModelList? products) {
    _products = products;
    notifyListeners();
  }

  Future<String?> _loadDataFromApi() async {
    //return await rootBundle.loadString('assets/$asset.json');
    return await ApiManager().getApiData();
  }

  Future<String?> _loadProductsDataFromApi() async {
    //return await rootBundle.loadString('assets/$asset.json');
    return await ApiServices().getDataDb();
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
    updatePageLoadingState(LoadState.loading);
    user = await DatabaseHelperDb.instance.getUserList();
    //user = await ApiManager().getData();
    //lists?.userList = user;
    debugPrint('length ${user?.length}');
    if (user == null || user!.isEmpty) {
      String? jsonString = await _loadDataFromApi();
      final jsonResponse = json.decode(jsonString!);
      UsersList data = UsersList.fromJson(jsonResponse);
      data.userList?.forEach((element) async {
        await _db.createUserList(element);
      });
      user = await _db.getUserList();
      //user = UsersList.fromJson(jsonResponse);
      // if (user != null) {
      //   await insertToUsers(lists);
      // }
    }
    updatePageLoadingState(LoadState.loaded);
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

  Future<void> loadProducts() async {
   // val= await DatabaseHelperDb.instance.getProduct();
   cartModel= await DatabaseHelperDb.instance.getProduct();
    // cartModel = CartModel.fromJson(jsonDecode(val));
    notifyListeners();
    debugPrint('length of products ${cartModel?.length}');
  }

Future<void>deleteAllData()async{
    await DatabaseHelperDb.instance.deleteAllData();
    await loadProducts();
   // await DatabaseHelperDb.instance.getProduct();
    notifyListeners();
}
Future<void> deleteData(int? id)async{
    await DatabaseHelperDb.instance.deleteData(id);
    await loadProducts();
    notifyListeners();
}
Future<void> addProductCart(int? id,int? count) async{
    await DatabaseHelperDb.instance.updateCount(id, count);
    await loadProducts();
    notifyListeners();
}


}
