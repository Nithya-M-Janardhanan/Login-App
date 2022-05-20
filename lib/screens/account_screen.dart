
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/auth_provider.dart';
import 'package:sample_task/provider/locale_provider.dart';
import '../generated/l10n.dart';
import 'loginscreen.dart';
import 'package:sample_task/provider/user_provider.dart';
import '../common/sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountScreen extends StatefulWidget {
  final String? location;
   AccountScreen({Key? key, this.location}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();

}

class _AccountScreenState extends State<AccountScreen> {
  bool isLanguage = false ;

  fetchInitialLanguage()async{
    await SharedPreferenceHelper.getLocale().then((value) => {
      setState(() {
        if(value == 'en'){
          isLanguage = false;
        }else{
          isLanguage = true;
        }
      })
    });
  }
  @override
  void initState() {
    fetchInitialLanguage();
    Future.microtask(() => context.read<AuthProvider>().getUser());
    Future.microtask(() => context.read<AuthProvider>().sensorfn());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(title:  Text(translated.accountScreen),backgroundColor: Colors.teal,),
      body:  SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, snapshot,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding:  EdgeInsets.only(top: 20,),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/user-avatar-profile-icon-black-vector-illustration-vector-id1209654046?k=20&m=1209654046&s=612x612&w=0&h=Atw7VdjWG8KgyST8AXXJdmBkzn0lvgqyWod9vTb2XoE='),
                  )
                ),
                const SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: ListTile(
                        leading: const Icon(Icons.person,color: Colors.black,),
                        title: Text(snapshot.socialEmail.isNotEmpty ? snapshot.socialEmail : 'No name',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)

                )

                 ),
                const SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: ListTile(
                    leading:const Icon(Icons.location_on,color: Colors.red,),
                    title: Text(snapshot.localityName.isNotEmpty?snapshot.localityName : translated.noSavedLocation,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12))

                ),
                 ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.language,color: Colors.black,),
                    title: Row(
                      children: [
                        Text(translated.language,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                        Spacer(),
                        Text(translated.english,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                        Switch(
                          onChanged: (value){
                            if(isLanguage == false)
                            {
                              setState(()  {
                                isLanguage = true;
                                Future.microtask((){
                                  context.read<LocaleProvider>().updateSelectedLanguage('ar');
                                });

                                // textValue = 'Switch Button is ON';
                              });
                            }
                            else
                            {
                              setState(()  {
                                isLanguage = false;
                                Future.microtask((){
                                  context.read<LocaleProvider>().updateSelectedLanguage('en');
                                });
                                // textValue = 'Switch Button is OFF';
                              });
                            }
                          },
                          value: isLanguage,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.teal,
                        ),
                        Text(translated.arabic,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Visibility(
                    visible: snapshot.visible,
                    child: ListTile(
                      leading: const Icon(Icons.fingerprint,color: Colors.black,),
                      title:
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                         Text(translated.turnOnFingerPrint,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                        Spacer(),
                        Switch(
                          value:snapshot.isSwitched,
                          onChanged: (value)async{
                            try{
                              snapshot.hasBioSensor = await snapshot.authentication.canCheckBiometrics;
                              if(snapshot.hasBioSensor!){
                                setState(()  {
                                  snapshot.isSwitched=value;
                                });
                                await SharedPreferenceHelper.setSensor(true);
                                // getAuth();
                              }
                              if(snapshot.isSwitched==false){
                                await SharedPreferenceHelper.setSensor(false);
                              }
                            }catch(err){
                              debugPrint('$err');
                            }
                          },
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.teal,
                        )
                      ],
                    ))
                  ),
                ),
                const SizedBox(height: 60.0,),
                ElevatedButton(
                    style:  ElevatedButton.styleFrom(primary: Colors.teal),
                    onPressed: ()async{
                  if(LoginScreen.checkLogin == 'google'){
                    Provider.of<UserProvider>(context, listen: false)
                        .googleLogout(context);
                  }else if(LoginScreen.checkLogin == 'facebook'){
                    Provider.of<UserProvider>(context, listen: false)
                        .fbLogOut(context);
                  }
                  else{
                    SharedPreferences shared = await SharedPreferences.getInstance();
                    shared.remove('email');
                    await SharedPreferenceHelper.clearUserData();
                  }
                  Navigator.of(context, rootNavigator: true).pushReplacementNamed( "/login",);
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, child:  Text(translated.logout)),
              ],
            );
          }
        ),
      )
    );
  }
}

// class LanguagePickerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LocaleProvider>(context,listen: false);
//     final locale = provider.locale;
//     return DropdownButtonHideUnderline(
//       child: DropdownButton(
//         value: locale,
//         icon: const Icon(Icons.arrow_drop_down_outlined),
//         // items:
//         //   L10n.all.map((locale) {
//         //     final lang = L10n.getLanguage(locale.languageCode);
//         //     return DropdownMenuItem(
//         //         child: Center(
//         //           child: Text(lang),
//         //         ),
//         //       value: locale,
//         //       onTap: (){
//         //           final provider = Provider.of<LocaleProvider>(context,listen: false);
//         //           provider.setLocale(locale);
//         //       },
//         //     );
//         //   }).toList(),
//         onChanged: (_){},
//         items: ,
//       ),
//
//     );
//   }
// }

