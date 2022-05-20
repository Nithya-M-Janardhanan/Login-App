import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../machine_test/home_provider.dart';
import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';
import '../provider/db_provider.dart';
import '../provider/favourites_provider.dart';
import '../provider/locale_provider.dart';
import '../provider/user_provider.dart';
import '../route_nav/nav_const.dart';
import '../route_nav/route_generator.dart';

class MyHomePage extends StatelessWidget {
  final  bool checkDebug;
  const MyHomePage({
    Key? key,
    required this.checkDebug
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
                ChangeNotifierProvider(create: (context) => CartProvider()),
                ChangeNotifierProvider(create: (context) => FavouritesProvider()),
              ],
              child:  Consumer<LocaleProvider>(
                  builder: (context, locale,child) {
                    return MaterialApp(
                        debugShowCheckedModeBanner: checkDebug,
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
