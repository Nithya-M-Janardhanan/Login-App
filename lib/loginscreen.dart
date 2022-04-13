import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'screens/homescreen.dart';
import 'package:sample_task/provider/user_provider.dart';
import 'package:sample_task/sharedpreferences.dart';
import 'package:sample_task/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class LoginScreen extends StatefulWidget {
  static String checkLogin = '';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool circular=false;

  //late final String email;
  @override
  void initState() {
    //showNotification();
    super.initState();
  }
  static showNotification(){
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
    //   }
    // });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sample Login App'),
        backgroundColor: Colors.teal,
      ),
      body:
           Form(
            key: _formKey,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Name',
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (value.length < 3) {
                        return 'Name must be more than 3 character';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your Email',
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                    validator: (String? value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value!)) {
                        return 'Enter valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Password',
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.length < 8) {
                          return 'Password must not be less than 8';
                        } else if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'must contain numbers';
                        } else if (!value
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'must contain one special character character';
                        } else if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'must contain one capital letter';
                        }
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    style:  ElevatedButton.styleFrom(primary: Colors.teal),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      //FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                       // if (emailController.text == 'abcd@gmail.com') {
                          SharedPreferenceHelper.setUsername(nameController.text);
                          LoginScreen.checkLogin = 'other';
                          await SharedPreferenceHelper.saveLoginMethod(
                              Const.otherUser);
                          Navigator.pushReplacementNamed(context, "/mainscreen");
                          //showNotification();
                          //showNotification();
                        /*} else {
                          final snackBar = SnackBar(
                              content: const Text('Enter the valid email -abcd@gmail.com'),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }*/
                        // email = emailController.text;
                        //  SharedPreferences sharedPref =
                        //  await SharedPreferences.getInstance();
                        //  sharedPref.setString('email', emailController.text);

                        // SharedPreferenceHelper.setUsername(emailController.text);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  HomeScreen(email: emailController.text,)));

                      }
                    },
                    child: const Text('Login')),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'OR',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SocialLoginTile(
                  icon: 'assets/images/googleforsample.png',
                  onTap: () {

                    Provider.of<UserProvider>(context, listen: false)
                        .googleLogin(context).then((value){
                      circular = true;
                    });
                    debugPrint('%%%%%%%%%%%%%%%%$circular');
                    LoginScreen.checkLogin = 'google';
                  },
                  title: 'Login with google',
                ),
                SocialLoginTile(
                  icon: 'assets/images/fbsample.png',
                  onTap: () {

                    Provider.of<UserProvider>(context, listen: false)
                        .fbLogin(context);

                    LoginScreen.checkLogin = 'facebook';
                  },
                  title: 'Login with facebook',
                ),
              circular==true?
      const CircularProgressIndicator() : SizedBox()
              ],
            ),
          )
    );
  }
}

class SocialLoginTile extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;

  const SocialLoginTile(
      {Key? key, this.title = '', required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 48.0,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5.0,
              ),
              Image.asset(
                icon,
                height: 22.0,
                width: 22.0,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
