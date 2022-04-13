import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://media.istockphoto.com/vectors/user-avatar-profile-icon-black-vector-illustration-vector-id1209654046?k=20&m=1209654046&s=612x612&w=0&h=Atw7VdjWG8KgyST8AXXJdmBkzn0lvgqyWod9vTb2XoE='),
                ),
                SizedBox(height: 10,),
                Text('Name'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        ListTile(
          onTap: (){

          },
          title: Text('Your Profile'),
          leading: Icon(Icons.person,color: Colors.black,),
        ),
        ListTile(
          onTap: (){

          },
          title: Text('Your Profile'),
          leading: Icon(Icons.person,color: Colors.black,),
        ),
        ListTile(
          onTap: (){

          },
          title: Text('Your Profile'),
          leading: Icon(Icons.person,color: Colors.black,),
        ),
        ListTile(
          onTap: (){

          },
          title: Text('Your Profile'),
          leading: Icon(Icons.person,color: Colors.black,),
        ),
      ],
    );
  }
}
