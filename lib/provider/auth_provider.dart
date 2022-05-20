import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import '../common/sharedpreferences.dart';

class AuthProvider extends ChangeNotifier{
  String socialEmail='';
  String localityName = '';

  bool isSwitched=false;

  /// biometrics
  bool visible = true;
  bool? hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  getUser()async{
    await SharedPreferenceHelper.getUsername().then((value) {
        socialEmail = value;
    });
    debugPrint('login method is ${await SharedPreferenceHelper.getLoginMethod()}');
    notifyListeners();
  }

  void sensorfn()async{
    isSwitched = await SharedPreferenceHelper.getSensor();
    visible = await authentication.canCheckBiometrics;
    notifyListeners();
  }
  sensorOperation(value)async{
    sensorfn();
    notifyListeners();
    try{
      hasBioSensor = await authentication.canCheckBiometrics;
      if(hasBioSensor!){

         isSwitched=value;

        await SharedPreferenceHelper.setSensor(true);
         notifyListeners();
        debugPrint('sharedpref value on...${await SharedPreferenceHelper.getSensor()}');
        debugPrint('is switched ....$isSwitched');

        // getAuth();
      }
      if(isSwitched==false){
        await SharedPreferenceHelper.setSensor(false);
        notifyListeners();
        debugPrint('sharedpref value off...${await SharedPreferenceHelper.getSensor()}');
      }
    }catch(err){
      debugPrint('$err');
    }
  }

  ///set location name
  Future<void> setLocationName(String locationName) async {
    await SharedPreferenceHelper.setLocation(locationName);
    localityName = locationName;
    notifyListeners();
  }

  Future<void> getLocationName() async {
    await SharedPreferenceHelper.getLocation();
    notifyListeners();
  }

///
}