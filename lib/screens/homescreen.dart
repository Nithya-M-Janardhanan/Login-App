import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/local_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/drawer_main.dart';
import 'package:sample_task/notification_service.dart';
import '../ex.dart';
import '../main.dart';
import '../map_related/gmap_screen.dart';
import 'package:sample_task/loginscreen.dart';
import 'package:sample_task/bottom_nav_screen.dart';
import 'package:sample_task/models/usermodel.dart';
import 'package:sample_task/navigation_drawer.dart';
import 'package:sample_task/provider/user_provider.dart';
import 'package:sample_task/screens/user_details_screen.dart';
import 'package:sample_task/services/api_manager.dart';
import 'package:sample_task/services/db.dart';
import 'package:sample_task/services/db_helper.dart';
import 'package:sample_task/services/db_provider.dart';
import 'package:sample_task/services/nav_const.dart';
import 'package:sample_task/sharedpreferences.dart';
import 'package:sample_task/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../const.dart';
import '../map_related/gmap_sample.dart';
import '../notification_data_screen.dart';

class HomeScreen extends StatefulWidget {
// static String loginMethod = '';
final  String? email;
    HomeScreen({Key? key,this.email}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  /// firebase push notification

  // static const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel','Important Notification',description: 'used for important notification',importance: Importance.high,playSound: true);
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  //   await Firebase.initializeApp();
  //   debugPrint('--------- A bg message ${message.messageId}');
  // }

  ///
  final textController = TextEditingController();
late  String socialEmail='';
// late Future<UserModel>? userModel;
  List<UserModel>? user;
  List<UserModel>? userOnSearch;
 bool isLoaded = false;
  bool isSwitched=false;
/// biometrics
  bool visible = true;
  bool? hasBioSensor;

  LocalAuthentication authentication = LocalAuthentication();

///end

  ///switch button

  ///end
  getUser()async{
    await SharedPreferenceHelper.getUsername().then((value) {
      setState(() {
        socialEmail = value;
      });
    });
    debugPrint('login method is ${await SharedPreferenceHelper.getLoginMethod()}');
  }
getVal() async{
    isSwitched = await SharedPreferenceHelper.getSensor();
    visible = await authentication.canCheckBiometrics;
    debugPrint('biosensor ....$visible');
}

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      debugPrint('!!!!!!!!!!!!!!!!!!');
      if(message != null){
        debugPrint('NEW NOTIFICATION//////');
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationData(data: message.data.isNotEmpty?message.data['id'] : '',)));
        if(message.data['_id'] != null){

        }
      }
    });
    ///
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('!!!!!!!!!!!!!!!!!!');
      if(message.notification != null){
        debugPrint('NEW NOTIFICATION//////');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationData(data: message.data.isNotEmpty?message.data['id'] : '')));
        if(message.data['_id'] != null){
          //LocalNotificationService.initialize();
          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationData()));
        }
      }
    });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if(notification != null && android != null){
    //     flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
    //         android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher'
    //         )
    //     ));
    //
    //    // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationData()));
    //   }
    // });
    FirebaseMessaging.onMessage.listen((message){
      flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"),),
          onSelectNotification: (String? id){
        if(message.data.isNotEmpty){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationData(data: message.data.isNotEmpty?message.data['id'] : '')));
        }
      });
        if(message.notification != null){
          LocalNotificationService.createAnddisplayNotification(message);
          
        }
    });
    ///

     getUser();
    Future.microtask(() => context.read<ContactsProvider>().loadUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMapScreen()));
            },
                icon: const Icon(Icons.location_on)
            )
            //Text('Hello $socialEmail !',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
          )
        ],
      ),
      body: Consumer<ContactsProvider>(builder: (context, model, child){
        if (model.user == null) {
          return const Center(child: CircularProgressIndicator(),);
        }
        return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Visibility(
            //     visible: visible,
            //       child: Row(
            //         children:  [
            //           Text('Turn on fingerprint'),
            //           Switch(
            //               value: isSwitched,
            //               onChanged: (value)async{
            //                 try{
            //                   hasBioSensor = await authentication.canCheckBiometrics;
            //                   if(hasBioSensor!){
            //                     setState(()  {
            //                       isSwitched=value;
            //                     });
            //                     await SharedPreferenceHelper.setSensor(true);
            //                     debugPrint('sharedpref value on...${await SharedPreferenceHelper.getSensor()}');
            //                     debugPrint('is switched ....$isSwitched');
            //                 // getAuth();
            //                 }
            //                   if(isSwitched==false){
            //                     // setState(() {
            //                     //   isSwitched=false;
            //                     // });
            //                     await SharedPreferenceHelper.setSensor(false);
            //                     debugPrint('sharedpref value off...${await SharedPreferenceHelper.getSensor()}');
            //                   }
            //                 }catch(err){
            //                 debugPrint('$err');
            //                 }
            //
            //               },
            //             activeColor: Colors.blue,
            //             activeTrackColor: Colors.green,
            //           )
            //         ],
            //       )
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    userOnSearch = model.user?.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();

                  });
                },
                controller: textController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0)
                    ),
                    hintText: 'Search name'
                ),
              ),
            ),
            textController.text.isNotEmpty && userOnSearch!.isEmpty ?
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:   const [
                Icon(Icons.search_off),
                Text('No Results Found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),) :
            Expanded(
              child: ListView.builder(
                // itemCount: snapshot.data!.name!.length,
                  itemCount: textController.text.isNotEmpty ? userOnSearch!.length :model.user?.length,
                  itemBuilder: (context,index){
                    var item = model.user?.elementAt(index);
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(textController.text.isNotEmpty ?
                              userOnSearch![index].profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : userOnSearch![index].profileImage :
                              item!.profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : item.profileImage),
                            radius: 18,
                            //   child:Image.network(textController.text.isNotEmpty ?
                            // userOnSearch![index].profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : userOnSearch![index].profileImage :
                            // item!.profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : item.profileImage),radius: 18,
                            ),
                            title: Text(textController.text.isNotEmpty ? userOnSearch![index].name.isNotEmpty?'Name : ${userOnSearch![index].name}' :'Name : ' :
                            item!.name.isNotEmpty?'Name : ${item.name}' :'Name : '
                            ),
                            subtitle: Text(textController.text.isNotEmpty ? userOnSearch![index].username.isNotEmpty?'Username : ${userOnSearch![index].username}' : 'UserName : ' :
                            item!.username.isNotEmpty?'Username : ${item.username}' : 'UserName : '
                            ),
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(userModel: textController.text.isNotEmpty ? userOnSearch![index] : item!)),);
                              Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=>UserDetails(userModel: textController.text.isNotEmpty ? userOnSearch![index] : item!)));
                              //textController.text = '';

                            },
                          )
                          //Text(user![index].name)
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
      drawer: const Drawer(
        child: NavigationDrawer(),
      ),
      /*Container(
        child: isLoaded ?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    userOnSearch = user!.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
                  });
                },
                controller: textController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0)
                  ),
                  hintText: 'Search name'
                ),
              ),
            ),
            textController.text.isNotEmpty && userOnSearch!.isEmpty ?
                 Center(child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:   const [
                    Icon(Icons.search_off),
                    Text('No Results Found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),) :
            Expanded(
              child: ListView.builder(
                       // itemCount: snapshot.data!.name!.length,
                      itemCount: textController.text.isNotEmpty ? userOnSearch!.length :user?.length,
                        itemBuilder: (context,index){
                         // var value = snapshot.data!.name![index];
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(child:Image.network(textController.text.isNotEmpty ?
                              userOnSearch![index].profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : userOnSearch![index].profileImage :
                                  user![index].profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : user![index].profileImage),radius: 18,),
                               title: Text(textController.text.isNotEmpty ? userOnSearch![index].name.isNotEmpty?'Name : ${userOnSearch![index].name}' :'Name : ' :
                                   user![index].name.isNotEmpty?'Name : ${user![index].name}' :'Name : '
                               ),
                               subtitle: Text(textController.text.isNotEmpty ? userOnSearch![index].username.isNotEmpty?'Username : ${userOnSearch![index].username}' : 'UserName : ' :
                                   user![index].username.isNotEmpty?'Username : ${user![index].username}' : 'UserName : '
                               ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(userModel: textController.text.isNotEmpty ? userOnSearch![index] : user![index])));
                                //textController.text = '';

                              },
                            )
                            //Text(user![index].name)
                          ],
                        ),
                      );
                    }),
            ),
          ],
        ) : const Center(child: CircularProgressIndicator(),)

      ),*/
    );
  }
}
     /* Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text('Welcome!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const SizedBox(height: 20.0,),
            ElevatedButton(onPressed: () async{
              if(LoginScreen.checkLogin == 'google'){
                Provider.of<UserProvider>(context, listen: false)
                    .googleLogout(context);
                //HomeScreen.loginMethod ='';
              }else if(LoginScreen.checkLogin == 'facebook'){
                Provider.of<UserProvider>(context, listen: false)
                    .fbLogOut(context);
               // HomeScreen.loginMethod ='';
              }
              else{
                SharedPreferences shared = await SharedPreferences.getInstance();
                shared.remove('email');
                await SharedPreferenceHelper.clearUserData();
               // HomeScreen.loginMethod ='';
              }
              /*SharedPreferences shared = await SharedPreferences.getInstance();
              shared.remove('email');
              debugPrint('logged out...');
              //Provider.of<UserProvider>(context,listen: false).googleLogout(context);
              Provider.of<UserProvider>(context,listen: false).fbLogOut(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));*/
              //userLogOut(loginMethod: loginMethod, context: context);
              ///Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              Navigator.pushReplacementNamed(context, "/login");
            },
                child: const Text('Log out')
            )
          ],
        ),
      ),*/


  // static Future<void> userLogOut(
  //     {required String loginMethod, required BuildContext context}) async {
  //   switch (loginMethod) {
  //     case Const.googleUser:
  //       Provider.of<UserProvider>(context, listen: false)
  //           .googleLogout(context);
  //       break;
  //     case Const.facebookUser:
  //       Provider.of<UserProvider>(context, listen: false)
  //           .fbLogOut(context);
  //       break;
  //
  //     default:
  //       SharedPreferences shared = await SharedPreferences.getInstance();
  //       shared.remove('email');
  //   }
  // }



