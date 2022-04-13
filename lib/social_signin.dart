import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialSignIn{
  static final googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? googleAccount;
  static var mail;
  static var name;
  static List<String> googleData = [];
  Map? fbDetails;

  static Future<List<String>> signInWithGoogle() async {
    googleAccount = await googleSignIn.signIn();
    googleData.add(googleAccount!.email);
    googleData.add(googleAccount!.displayName ?? '');
    mail = googleAccount!.email;
    name = googleAccount!.displayName;
    return googleData;
  }

  static Future<bool> signOutGoogle() async {
    bool flag = false;
    try {
      await googleSignIn.isSignedIn().then((value) async {
        if (value == true) {
          googleAccount = await googleSignIn.signOut();
          googleData = [];
          flag = true;
        } else {
          flag = true;
        }
      });
    } catch (_) {
      flag = false;
    }
    return flag;
  }

  static Future<dynamic> signInFacebook() async {
    try {
      final result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final requestData = await FacebookAuth.i
            .getUserData(fields: 'email,name,first_name,last_name');
        return requestData;
        //userData = requestData;
      } else {
        debugPrint('errorr>>>>>>>>>>>>>>>>>>>>>>>>');
      }
    }catch(error){
      debugPrint("Facebook login error $error");
    }
  }

  static Future<dynamic> signOutFacebook() async {
    await FacebookAuth.i.logOut();
  }
}