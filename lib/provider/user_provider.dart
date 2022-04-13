import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_task/loginscreen.dart';
import 'package:sample_task/main.dart';
import '../screens/homescreen.dart';
import 'package:sample_task/sharedpreferences.dart';
import 'package:sample_task/social_signin.dart';

import '../const.dart';

class UserProvider extends ChangeNotifier{
  bool isLoading = false;
  bool test =false;
  var email;
  var name;
  String fname = '';
  String lname = '';
  Map? fbDetails;
  late List<String> gname;
  showNotifications(){
    flutterLocalNotificationsPlugin.show(0,
        'Testing',
        'for testing',
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'
            )
        )
    );
  }
  googleLogin(BuildContext context) async {
    isLoading = true;

      try {
        SocialSignIn.signInWithGoogle().then((value) async {
          //await SharedPreferencesHelper.saveLoginMethod(Const.googleUser);
          await SharedPreferenceHelper.saveLoginMethod(Const.googleUser);

          if (value.isNotEmpty) {
            test=true;
            debugPrint('google details.................$value');
            email = value[0];
            //name = value[1].split(' ');
            name = value[1];
            fname = name[0];
            lname = name[1];
            debugPrint('google fname.................$fname');
            debugPrint('google lname.................$lname');
            await SharedPreferenceHelper.setUsername(name);
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(email: email,)));
            Navigator.pushReplacementNamed(context, "/mainscreen");
            //showNotifications();
          }
          isLoading = false;
          test=false;
          notifyListeners();
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
  }
  Future<void> googleLogout(BuildContext context) async {
      try {
        SocialSignIn.signOutGoogle().then((value) async {
          if (value) {
              email = '';
              name = '';
              fname = '';
              lname = '';
              SharedPreferenceHelper.clearUserData();
              notifyListeners();
              debugPrint('name after logged out...$name');
          }
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
  }

  fbLogin(BuildContext context) async {
    isLoading = true;
      try {
        SocialSignIn.signInFacebook().then((value) async {
          //await SharedPreferencesHelper.saveLoginMethod(Const.facebookUser);
          await SharedPreferenceHelper.saveLoginMethod(Const.facebookUser);
          if (value != null) {
            fbDetails = value;
            name = fbDetails!['name'];
            email = fbDetails!['email'];
            debugPrint('fb details....${fbDetails!['name']}');
            debugPrint('fb details....${fbDetails!['email']}');
            await SharedPreferenceHelper.setUsername(name);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(email: email,)));
            Navigator.pushReplacementNamed(context, "/mainscreen");
            //showNotifications();
          }
          isLoading = false;
          notifyListeners();
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
    }

  Future<void> fbLogOut(BuildContext context) async {
      try {
        SocialSignIn.signOutFacebook().then((value) async {
          fbDetails = {};
          SharedPreferenceHelper.clearUserData();
          notifyListeners();
          debugPrint('logout fbdetails..........$fbDetails');
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
  }
}