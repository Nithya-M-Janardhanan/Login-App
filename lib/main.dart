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

  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,810),
      builder:(child){
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => UserProvider()),
              ChangeNotifierProvider(create: (context) => ContactsProvider()),
              ChangeNotifierProvider(create: (context) => AuthProvider()),
              ChangeNotifierProvider(create: (context) => LocaleProvider()),
              ChangeNotifierProvider(create: (context) => HomeProvider()),
            ],
            child:  Consumer<LocaleProvider>(
                builder: (context, locale,child) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      onGenerateRoute: NavRouteGenerator.generateRoute,
                      initialRoute: initialRoute,
                      localizationsDelegates: [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate
                      ],
                      locale: locale.locale,
                      supportedLocales: S.delegate.supportedLocales
                  );
                }
            )
        );
      }
    );
  }
}
