import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/common_textfield.dart';

class SampleTextField extends StatefulWidget {
  const SampleTextField({Key? key}) : super(key: key);

  @override
  State<SampleTextField> createState() => _SampleTextFieldState();
}

class _SampleTextFieldState extends State<SampleTextField> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 200,),
            CustomTextFormField(
              controller: emailController,
              hintText: 'Enter Email',
              labelText: 'Email Address',
              validator: (String? value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value!)) {
                  return 'Enter valid email';
                } else {
                  return '';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
