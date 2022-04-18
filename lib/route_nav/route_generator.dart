import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/account_screen.dart';
import '../screens/loginscreen.dart';
import '../widgets/bottom_nav_screen.dart';
import 'package:sample_task/screens/homescreen.dart';
import 'package:sample_task/screens/user_details_screen.dart';
import '../screens/sensor.dart';
import '../screens/splashscreen.dart';

import 'nav_const.dart';

class NavRouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings,{dynamic arguments}) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
           // settings: RouteSettings(name: initialRoute),
            builder: (_) => SplashScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case loginScreenRoute:
        //var val = settings.arguments;
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case sensorScreenRoute:
        return MaterialPageRoute(builder: (_) => Sensor());
      case mainScreenRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case accountScreenRoute:
        var location=settings.arguments;
        return MaterialPageRoute(builder: (_)=>AccountScreen(location: arguments,));
      case userDetailScreenRoute:
        return MaterialPageRoute(builder: (_) => UserDetails(userModel: arguments));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
