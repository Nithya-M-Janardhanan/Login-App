

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'widgets/bottom_nav_screen.dart';
import 'services/notification_service.dart';
import 'screens/sensor.dart';
import 'provider/db_provider.dart';
import 'route_nav/nav_const.dart';
import 'route_nav/route_generator.dart';
import 'screens/notification_data_screen.dart';
import 'screens/homescreen.dart';
import 'screens/loginscreen.dart';
import 'package:sample_task/provider/user_provider.dart';
import 'screens/splashscreen.dart';

import 'route_nav/route_generator.dart' as route;

const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel','Important Notification',description: 'used for important notification',importance: Importance.high,playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  runApp( const MyHomePage());
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ContactsProvider()),
    ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route.NavRouteGenerator.generateRoute,
        initialRoute: initialRoute,
      ),

    );
  }
}
