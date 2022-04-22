import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/auth_provider.dart';
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

  @override
  void initState() {
    Future.microtask(() => context.read<AuthProvider>().getUser());
    Future.microtask(() => context.read<AuthProvider>().sensorfn());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Screen'),backgroundColor: Colors.teal,),
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
                    title: Text(snapshot.localityName.isNotEmpty?snapshot.localityName : 'No Saved Location',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12))

                ),
                 ),
                const SizedBox(height: 20,),
                Text('Language'),
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
                        const Text('Turn on fingerprint',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
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
                                debugPrint('sharedpref value on...${await SharedPreferenceHelper.getSensor()}');
                                debugPrint('is switched ....${snapshot.isSwitched}');
                                // getAuth();
                              }
                              if(snapshot.isSwitched==false){
                                await SharedPreferenceHelper.setSensor(false);
                                debugPrint('sharedpref value off...${await SharedPreferenceHelper.getSensor()}');
                              }
                            }catch(err){
                              debugPrint('$err');
                            }

                          },
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.green,
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
                }, child: const Text('Logout')),
              ],
            );
          }
        ),
      )
    );
  }
}
