import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_task/models/arguments.dart';
import 'package:sample_task/route_nav/nav_const.dart';

class LocalNotificationService {
  // static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late BuildContext context;
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', 'Important Notification',
      description: 'used for important notification',
      importance: Importance.high,
      playSound: true);

  //static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static void initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? id) async {
      if (id!.isNotEmpty) {
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationData()));
      }
    });
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'));
      await notificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id']);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  ///
  static initializeNotificationHome(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        ArgumentsRoute route = ArgumentsRoute(
            id: message.data.isNotEmpty ? message.data['id'] : '');
        Navigator.pushNamed(context, notificationDataScreenRoute,
            arguments: route);
        if (message.data['_id'] != null) {}
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        ArgumentsRoute route = ArgumentsRoute(
            id: message.data.isNotEmpty ? message.data['id'] : '');
        Navigator.pushNamed(context, notificationDataScreenRoute,
            arguments: route);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      notificationsPlugin.initialize(
          const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          ), onSelectNotification: (String? id) {
        if (message.data.isNotEmpty) {
          ArgumentsRoute route = ArgumentsRoute(
              id: message.data.isNotEmpty ? message.data['id'] : '');
          Navigator.pushNamed(context, notificationDataScreenRoute,
              arguments: route);
        }
      });
      if (message.notification != null) {
        createAndDisplayNotification(message);
      }
    });
  }
}
