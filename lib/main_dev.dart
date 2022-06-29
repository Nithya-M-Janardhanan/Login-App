import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_task/screens/my_homepage.dart';
import 'package:sample_task/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  await Hive.initFlutter();
  await Hive.openBox('shopping_box');
  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(const MyHomePage(checkDebug: false,));
}
