import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'screens/homescreen.dart';
import 'package:sample_task/provider/user_provider.dart';
import 'package:sample_task/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   String? finalEmail;
   String isLoggedin='';
  @override
  void initState() {
     getValidationData();
     // if(LoginScreen.checkLogin == 'google' || LoginScreen.checkLogin == 'facebook'){
     //   finalEmail = UserProvider().email;
     //   debugPrint('?????????????${UserProvider().email}');
     // }else if(LoginScreen.checkLogin == 'other'){
     //   finalEmail = HomeScreen().email;
     // }
     // else{
     //   finalEmail = '';
     // }
      Timer(const Duration(seconds: 2), ()async{
        if(await SharedPreferenceHelper.getSensor() == true){
          isLoggedin.isEmpty ? Navigator.pushReplacementNamed(context, "/login") : Navigator.pushReplacementNamed(context, "/sensor");
        }else {
          isLoggedin.isEmpty
              ? Navigator.pushReplacementNamed(context, "/login")
              : Navigator.pushReplacementNamed(context, "/mainscreen");
        }
       // isLoggedin.isEmpty ? Navigator.pushReplacementNamed(context, "/login") : Navigator.pushReplacementNamed(context, "/sensor");
      });
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>finalEmail ==  null ? LoginScreen() : const HomeScreen())));

    super.initState();
  }

  Future getValidationData() async{
    await SharedPreferenceHelper.getLoginMethod().then((value) {
      setState(() {
        if(value != null){
          isLoggedin = value;
        }

      });
    });
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var obtainedEmail = sharedPreferences.getString('email');
    // setState(() {
    //   finalEmail = obtainedEmail!;
    // });
    // debugPrint('>>>>>>>>>>>$finalEmail');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.teal,
              child: Icon(Icons.supervised_user_circle),
              radius: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
