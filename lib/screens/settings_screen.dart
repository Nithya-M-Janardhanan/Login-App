import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(title:  Text(translated.settingsScreen),backgroundColor: Colors.teal,),
      body:  Center(
        child: Text(translated.settingsScreen),
      ),
    );
  }
}
