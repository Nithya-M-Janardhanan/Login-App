import 'package:flutter/cupertino.dart';

import '../common/helpers.dart';
import '../machine_test/homemodel.dart';
import '../services/db_helper.dart';

class CartProvider extends ChangeNotifier{
  final DatabaseHelperDb _db = DatabaseHelperDb.instance;
  List<CartModel>? cartModel;
  int totalCartCount = 0;

  Future<void> insertProducts(Value value) async {
    await _db.createProductList(value);
    await loadProducts();
    Helpers.successToast('Product added to cart');
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

  Future<void> updateCountfn(int? id,int? count) async{
    await DatabaseHelperDb.instance.updateCount(id, count);
    await loadProducts();
    notifyListeners();
  }
}