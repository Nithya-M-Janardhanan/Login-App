import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer_item.dart';
import 'sample_file.dart';
import '../common/sharedpreferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late  String userName='';
  getUser()async{
    await SharedPreferenceHelper.getUsername().then((value) {
      setState(() {
        userName = value;
      });
    });
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 40,),
              const Divider(thickness: 1,color: Colors.white,),
              const SizedBox(height: 40,),
              DrawerItem(name: 'Your Profile', icon: Icons.person, onPressed: (){onItemPressed(context, index: 0);}),
              DrawerItem(name: 'Dashboard', icon: Icons.dashboard, onPressed: (){onItemPressed(context, index: 1);}),
              DrawerItem(name: 'Favourites', icon: Icons.favorite_border_outlined, onPressed: (){onItemPressed(context, index: 2);}),
              DrawerItem(name: 'Saved', icon: Icons.save, onPressed: (){onItemPressed(context, index: 3);}),
              DrawerItem(name: 'Invite', icon: Icons.person_add, onPressed: (){onItemPressed(context, index: 4);}),
            ],
          ),
        ),
      ),
    );
  }
  void onItemPressed(BuildContext context,{required int index}){
    Navigator.pop(context);
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Sample()));
        break;

    }
  }

  Widget headerWidget(){
    return Row(
      children:  [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/user-avatar-profile-icon-black-vector-illustration-vector-id1209654046?k=20&m=1209654046&s=612x612&w=0&h=Atw7VdjWG8KgyST8AXXJdmBkzn0lvgqyWod9vTb2XoE='),
          radius: 40,
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
              Text(userName.isNotEmpty?"$userName" : 'Name',style: TextStyle(color: Colors.white),),
            const SizedBox(height: 10,),
            Text('+9199225822565',style: TextStyle(color: Colors.white),)
          ],
        )
      ],
    );
  }
}
