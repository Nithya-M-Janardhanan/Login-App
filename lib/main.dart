import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/auth_provider.dart';
import 'package:sample_task/provider/locale_provider.dart';
import 'package:sample_task/route_nav/route_generator.dart';
import 'package:sample_task/screens/my_homepage.dart';
import 'generated/l10n.dart';
import 'machine_test/home_provider.dart';
import 'services/notification_service.dart';
import 'provider/db_provider.dart';
import 'route_nav/nav_const.dart';
import 'package:sample_task/provider/user_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();

  runApp(const MyHomePage(checkDebug: true,));
}

