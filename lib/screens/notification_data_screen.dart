import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_task/generated/l10n.dart';

class NotificationData extends StatefulWidget {
  final String? data;

  const NotificationData({Key? key, required this.data}) : super(key: key);

  @override
  _NotificationDataState createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translated.notification),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(widget.data ?? translated.noData),
      ),
    );
  }
}
