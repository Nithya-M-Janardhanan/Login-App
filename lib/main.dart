

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/bottom_nav_screen.dart';
import 'package:sample_task/notification_service.dart';
import 'package:sample_task/sensor.dart';
import 'package:sample_task/services/db_provider.dart';
import 'package:sample_task/services/nav_const.dart';
import 'package:sample_task/services/route_generator.dart';
import 'notification_data_screen.dart';
import 'screens/homescreen.dart';
import 'package:sample_task/loginscreen.dart';
import 'package:sample_task/provider/user_provider.dart';
import 'package:sample_task/splashscreen.dart';

import 'services/route_generator.dart' as route;

const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel','Important Notification',description: 'used for important notification',importance: Importance.high,playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  debugPrint('--------- A bg message ${message.messageId.toString()}');
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

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
  void initState() {

  /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if(notification != null && android != null){
      showDialog(context: context,
          builder: (_){
            return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
            );
          }
      );
    }
  });*/
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
        //routes:
        //NavRouteGenerator.generateRoutes(),
        // {
        //   "/home" :(_)=>HomeScreen(),
        //   "/login" :(_)=>LoginScreen(),
        //   "/sensor" :(_)=>Sensor(),
        //   "/mainscreen" :(_)=>MainScreen(),
        // },
      ),

    );
  }
}
