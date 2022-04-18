import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import '../common/sharedpreferences.dart';
import 'splashscreen.dart';

class Sensor extends StatefulWidget {
  @override
  _SensorState createState() => _SensorState();
}

class _SensorState extends State<Sensor> {
  bool visible = false;


  LocalAuthentication authentication = LocalAuthentication();
  Future<void> checkBio() async{
    try{
      if(await SharedPreferenceHelper.getSensor() == true){
         getAuth();
      }
    }catch(err){
      debugPrint('$err');
    }
  }

  Future<void> getAuth() async{
    bool isAuth = false;
    try{
      if(await SharedPreferenceHelper.getSensor() == true) {
        isAuth = await authentication.authenticate(
            localizedReason: 'Scan your fingerprint to login',
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true
        );
      }
      if(isAuth){
        Navigator.pushReplacementNamed(context, "/mainscreen");
        debugPrint('nithya');
      }
      debugPrint('$isAuth');
    }catch(err){
      debugPrint('$err');
    }
  }
  @override
  void initState() {
    getAuth();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Container(

    );
  }
}
