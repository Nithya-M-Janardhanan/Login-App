import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../generated/l10n.dart';
import '../screens/account_screen.dart';
import '../route_nav/nav_const.dart';
import '../route_nav/route_generator.dart';
import '../screens/settings_screen.dart';
import '../screens/fav_screen.dart';
import 'package:sample_task/screens/homescreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PersistentTabController controller;

   @override
  void initState() {
     controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.teal,),label: translated.home,),
      BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.teal),label: translated.account,),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.teal),label: translated.favourites,),
      BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.teal),label: translated.menuSettings,),
    ],),
        tabBuilder: (context,index){
          switch(index){
            case 0:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(child: HomeScreen());
              },
              onGenerateRoute: (settings) => NavRouteGenerator.generateRoute(settings),);
            case 1:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(child: SettingsScreen());
              },
                  onGenerateRoute: (settings) => NavRouteGenerator.generateRoute(settings));
            case 2:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(child: FavScreen());
              },
                  onGenerateRoute: (settings) => NavRouteGenerator.generateRoute(settings));
            case 3:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(child: AccountScreen());
              },
                  onGenerateRoute: (settings) => NavRouteGenerator.generateRoute(settings));
            default:
              return CupertinoTabView(builder: (context){
                return CupertinoPageScaffold(child: HomeScreen());
              },
                  onGenerateRoute: (settings) => NavRouteGenerator.generateRoute(settings));
          }
        }
    );

  }
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SettingsScreen(),
      FavScreen(),
      AccountScreen(),
    ];
  }

}
