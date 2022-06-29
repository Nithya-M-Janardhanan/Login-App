import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/screens/sample_textfield.dart';
import '../common/sharedpreferences.dart';
import '../hive/hive_home.dart';
import '../provider/locale_provider.dart';
import 'calendar_new.dart';
import 'calender_ex.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;
  String isLoggedin = '';
     FirebaseRemoteConfig? remoteConfig ;

  Future<void> initConfig() async {
    // remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig?.ensureInitialized();
    // try{
    //   await remoteConfig?.setConfigSettings(RemoteConfigSettings(
    //     fetchTimeout: const Duration(seconds: 10),
    //     minimumFetchInterval: Duration.zero, // fetch parameters will be cached for a maximum of 1 hour
    //   ));
    //   await remoteConfig?.fetchAndActivate();
    // }catch(err){
    //   print(err);
    // }
    // String test = remoteConfig?.getString('app_name') ?? '';
    // debugPrint('remote config value........$test');
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: Duration.zero
    ));
    await remoteConfig.fetchAndActivate();
    String test = remoteConfig.getString('test');
    debugPrint('remote config value........$test');
  }

  @override
  void initState() {
     initConfig();
     FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async{
       final Uri? deepLink = dynamicLink?.link;
       print(deepLink?.path);
     },
         onError: (OnLinkErrorException e)async
         {
           print('===========${e.message}');
         }
     );
     Future.microtask(() async{
       final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
       final Uri? deepLink = data?.link;

       if (deepLink != null) {
         print('-------------${deepLink.path}');
         // Navigator.pushNamed(context, deepLink.path);
       }
     });
    // Future.microtask(() async{
    //   final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    //   final Uri? deepLink = data?.link;
    //
    //   if (deepLink != null) {
    //     print(deepLink.path);
    //     // Navigator.pushNamed(context, deepLink.path);
    //   }
    // });
    Future.microtask(() => context.read<LocaleProvider>().getLocalLocale());
    getValidationData();
    Timer(const Duration(seconds: 2), () async {
      /*if (await SharedPreferenceHelper.getSensor() == true) {
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

      }*/
     Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderEx()));
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
