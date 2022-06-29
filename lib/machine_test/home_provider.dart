
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

import 'homemodel.dart';
import 'machine_api.dart';

class HomeProvider extends ChangeNotifier{
  HomeModel? homeModel;

  Future<void> getData() async{
    Future.delayed(Duration(seconds: 1),()async{
      homeModel = await ApiServices().getData();
      notifyListeners();
    });


  }

}
