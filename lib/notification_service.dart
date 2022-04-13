

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';
import 'notification_data_screen.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin notificationsPlugin=FlutterLocalNotificationsPlugin();
  static late BuildContext context;

  static void initialize(){
    InitializationSettings initializationSettings=InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher")
    );
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? id)async{
          debugPrint('======== on select notification');
          if(id!.isNotEmpty){
            debugPrint('======== id is $id');
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationData()));
          }
        }
    );
  }
  static void createAnddisplayNotification(RemoteMessage message)async{
    try{
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'
          )
      );
      await notificationsPlugin.show(message.hashCode, message.notification!.title, message.notification!.body, notificationDetails,payload: message.data['_id']);
    }on Exception catch(e){
        debugPrint('$e');
    }
  }
}
