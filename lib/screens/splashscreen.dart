import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/sharedpreferences.dart';
import '../provider/locale_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;
  String isLoggedin = '';

  @override
  void initState() {
    Future.microtask(() => context.read<LocaleProvider>().getLocalLocale());
    getValidationData();
    Timer(const Duration(seconds: 2), () async {
      if (await SharedPreferenceHelper.getSensor() == true) {
        if(mounted){
          isLoggedin.isEmpty
              ? Navigator.pushReplacementNamed(context, "/login")
              : Navigator.pushReplacementNamed(context, "/sensor");
        }

      } else {
        if(mounted){
          isLoggedin.isEmpty
              ? Navigator.pushReplacementNamed(context, "/login")
              : Navigator.pushReplacementNamed(context, "/mainscreen");
        }

      }
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomepage()));
    });


    super.initState();
  }

  Future getValidationData() async {
    await SharedPreferenceHelper.getLoginMethod().then((value) {
      setState(() {
        if (value != null) {
          isLoggedin = value;
        }
      });
    });
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
