import 'package:flutter/cupertino.dart';

import '../common/sharedpreferences.dart';


class LocaleProvider extends ChangeNotifier{
   Locale? _locale;
  Locale get locale => _locale ?? const Locale('en');
   String language = '';
   String selectedLanguage = '';
   bool isLanguage = false ;

  void setLocale(Locale locale){
    //if(!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
   Future<void> getLocalLocale() async {
     language = await SharedPreferenceHelper.getLocale();
     _locale = Locale(language);
     notifyListeners();
   }
   Future<void> updateSelectedLanguage(String val) async{
     _locale = Locale(val);
     SharedPreferenceHelper.setLocale(val);
     notifyListeners();
   }

  // void clearLocale(){
  //   //_locale = null;
  //   notifyListeners();
  // }

// void switchLanguage() async{
//     isLanguage = await SharedPreferenceHelper.getLocale().then((value){
//       if(value=='en'){
//
//       }
//     });
// }
}