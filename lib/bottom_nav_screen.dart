import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sample_task/account_screen.dart';
import 'package:sample_task/services/nav_const.dart';
import 'package:sample_task/services/route_generator.dart';
import 'package:sample_task/settings_screen.dart';
import 'package:sample_task/fav_screen.dart';
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
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(items: const[
      BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.teal,),label: 'Home',),
      BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.teal),label: 'Account',),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.teal),label: 'Favourites',),
      BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.teal),label: 'Menu Settings',),
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
      // Scaffold(
      // body: PersistentTabView(
      //   context,
      //   controller: controller,
      //   screens: _buildScreens(),
      //   items: _navBarsItems(),
      //   confineInSafeArea: true,
      //   backgroundColor: Colors.white, // Default is Colors.white.
      //   handleAndroidBackButtonPress: true, // Default is true.
      //   resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      //   stateManagement: true, // Default is true.
      //   hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //   decoration: NavBarDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     colorBehindNavBar: Colors.white,
      //   ),
      //   popAllScreensOnTapOfSelectedTab: true,
      //   popActionScreens: PopActionScreensType.all,
      //   itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 200),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     curve: Curves.ease,
      //     duration: Duration(milliseconds: 200),
      //   ),
      //   navBarStyle: NavBarStyle.style1,
      //   // Choose the nav bar style with this property.
      //   onItemSelected: (int val){
      //     setState(() {
      //       controller.index = val;
      //     });
      //   },
      // )
      //
      // );
  }
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SettingsScreen(),
      FavScreen(),
      AccountScreen(),
    ];
  }

  /*List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings:  RouteAndNavigatorSettings(

          routes: NavRouteGenerator.generateRoutes(),
        )
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:  RouteAndNavigatorSettings(

            routes: NavRouteGenerator.generateRoutes(),
          )
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.square_favorites_alt),
        title: ("Favourites"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:  RouteAndNavigatorSettings(

            routes: NavRouteGenerator.generateRoutes(),
          )
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt_circle_fill),
        title: ("Account"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings:  RouteAndNavigatorSettings(

            routes: NavRouteGenerator.generateRoutes(),
          ),
      ),
    ];
  }*/
}
