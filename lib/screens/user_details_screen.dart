import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_task/models/usermodel.dart';

class UserDetails extends StatefulWidget {
  final UserModel userModel;
  const UserDetails({Key? key, required this.userModel}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.userModel.profileImage.isEmpty ?'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png' : widget.userModel.profileImage),
                  radius: 50,
                ),
                const SizedBox(height: 40,),
                Text(widget.userModel.name.isNotEmpty?widget.userModel.name:'No Name',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading:const Icon(Icons.email_outlined,color: Colors.teal,),
                    title: Text('Email'),
                    subtitle: Text(widget.userModel.email.isNotEmpty?widget.userModel.email:' No email to show',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading:const Icon(Icons.phone,color: Colors.teal),
                    title: Text('Phone'),
                    subtitle: Text(widget.userModel.phone!.isNotEmpty?'${widget.userModel.phone}':'No phone number to show',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading:const Icon(Icons.streetview,color: Colors.teal),
                    title: Text('Street'),
                    subtitle: Text(widget.userModel.address.street.isNotEmpty?widget.userModel.address.street : 'No city to show',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading:const Icon(Icons.location_city,color: Colors.teal),
                    title: Text('City'),
                    subtitle: Text(widget.userModel.address.city.isNotEmpty?widget.userModel.address.city : 'No city to show',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading:const Icon(Icons.web,color: Colors.teal),
                    title: Text('Website'),
                    subtitle: Text(widget.userModel.website.isNotEmpty?widget.userModel.website : 'No website to show',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
