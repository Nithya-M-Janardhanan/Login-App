import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/db_provider.dart';
import '../common/const.dart';
import '../generated/l10n.dart';
import '../machine_test/hexcolor.dart';
import '../screens/account_screen.dart';
import '../route_nav/nav_const.dart';
import '../route_nav/route_generator.dart';
import '../screens/settings_screen.dart';
import '../screens/cart_screen.dart';
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
      BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,),label: translated.home,),
      BottomNavigationBarItem(icon: Icon(Icons.category_outlined,color: Colors.black),label: translated.category,),
      // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined,color: Colors.teal),label: 'Cart',),
      BottomNavigationBarItem(icon: Consumer<ContactsProvider>(
        builder: (context, snapshot,child) {
          // String num = snapshot.cartModel?.length.toString() ?? '0';
          String num = snapshot.totalCartCount.toString();
          return Stack(children: [
            Image.asset(Const.cartIcon,height: 18,width: 18,),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,),
              child: Material(
                child: Container(
                    height: 13.0,
                    width: 13.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor('#EF3234'),
                    ),
                    alignment: Alignment.center,
                    child:
                     FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(0.80),
                        child: Text(num,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
            ),
          ],);
        }
      ),label: 'Cart',),
      BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.black),label: translated.menuSettings,),
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
                return CupertinoPageScaffold(child: CartScreen());
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
      CartScreen(),
      AccountScreen(),
    ];
  }

}
