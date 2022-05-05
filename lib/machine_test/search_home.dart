import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../common/const.dart';
import 'hexcolor.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0,left: 8.0,right: 8.0),
        child: TextField(
          //enabled: false,
          onChanged: (value) {

          },
          controller: textController,
          decoration:  InputDecoration(
              prefixIcon: Image.asset(Const.searchIcon,height: 1.0,width: 1.0,),
              suffixIcon: Image.asset(Const.scanIcon,height: 1.0,width: 1.0,),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 3.0)),
              hintText: 'Search',hintStyle: TextStyle(color: HexColor('#727272'),fontSize: 16) ),
        ),
      ),
    );
  }
}
