import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationData extends StatefulWidget {
  final String? data;

  const NotificationData({Key? key, required this.data}) : super(key: key);

  @override
  _NotificationDataState createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(widget.data ?? 'No data'),
      ),
    );
  }
}
