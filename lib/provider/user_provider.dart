import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/sharedpreferences.dart';
import '../common/social_signin.dart';
import '../common/const.dart';

class UserProvider extends ChangeNotifier{
  bool isLoading = false;
  bool test =false;
  var email;
  var name;
  String fname = '';
  String lname = '';
  Map? fbDetails;
  late List<String> gname;

  /// sign in with google
  googleLogin(BuildContext context) async {
    isLoading = true;
      try {
        SocialSignIn.signInWithGoogle().then((value) async {
          //await SharedPreferencesHelper.saveLoginMethod(Const.googleUser);
          await SharedPreferenceHelper.saveLoginMethod(Const.googleUser);

          if (value.isNotEmpty) {
            test=true;
            email = value[0];
            name = value[1];
            fname = name[0];
            lname = name[1];
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
          }
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
  }

  /// sign with facebook
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
        });
      } catch (err) {
        debugPrint('error >>>>>>$err');
      }
  }
}