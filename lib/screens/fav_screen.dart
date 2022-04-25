import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(title:  Text(translated.favouritesScreen),backgroundColor: Colors.teal,),
      body:  Center(
        child: Text(translated.favouritesScreen),
      ),
    );
  }
}
