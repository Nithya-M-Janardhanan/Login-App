import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_task/models/arguments.dart';
import '../screens/account_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/loginscreen.dart';
import '../screens/notification_data_screen.dart';
import '../widgets/bottom_nav_screen.dart';
import 'package:sample_task/screens/homescreen.dart';
import 'package:sample_task/screens/user_details_screen.dart';
import '../screens/sensor.dart';
import '../screens/splashscreen.dart';

import 'nav_const.dart';

class NavRouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
           // settings: RouteSettings(name: initialRoute),
            builder: (_) => SplashScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case sensorScreenRoute:
        return MaterialPageRoute(builder: (_) => Sensor());
      case mainScreenRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case accountScreenRoute:
        return MaterialPageRoute(builder: (_)=>AccountScreen());
      case userDetailScreenRoute:
        ArgumentsRoute route = settings.arguments as ArgumentsRoute;
        return MaterialPageRoute(builder: (_) => UserDetails(userModel: route.userModel));
      case notificationDataScreenRoute:
        ArgumentsRoute route = settings.arguments as ArgumentsRoute;
        return MaterialPageRoute(builder: (_) => NotificationData(data: route.id,));
      case cartScreenRoute:
        return MaterialPageRoute(builder: (_)=>CartScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
