import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Screen'),backgroundColor: Colors.teal,),
      body: const Center(
        child: Text('Favourites Screen'),
      ),
    );
  }
}
