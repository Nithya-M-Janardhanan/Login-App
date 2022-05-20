import 'package:flutter/cupertino.dart';

import '../machine_test/homemodel.dart';
import '../services/db_helper.dart';

class FavouritesProvider extends ChangeNotifier{
  final DatabaseHelperDb _db = DatabaseHelperDb.instance;
  List<FavouritesModel>? favList;

  Future<void> insertFavItems(Value value) async{
    await _db.createFavouritesList(value);
    await loadFavList();
    notifyListeners();
  }

  Future<void> loadFavList() async{
    favList = await DatabaseHelperDb.instance.getFavoritesList();
    notifyListeners();
  }

  Future<void> deleteFavouritesItem(int? id)async{
    await DatabaseHelperDb.instance.deleteFavItem(id);
    await loadFavList();
    notifyListeners();
  }
}