import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 1.0,color: Colors.grey)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey[300],),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Text('kjdsncjksncdw',),
                            Text('kjnbdjknd kojedkewjdkwejdw jkwenfkjenwjfkjke')
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.menu)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 1.0,color: Colors.grey)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey[300],),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Text('kjdsncjksncdw'),
                            Text('kjnbdjknd kojedkewjdkwejdw jkwenfkjenwjfkjke jnjknkjkj',)
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.menu)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
             decoration: BoxDecoration(
               shape: BoxShape.rectangle,
               borderRadius: BorderRadius.circular(5.0),
               border: Border.all(width: 1.0,color: Colors.grey)
             ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey[300],),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('kjdsncjksncdw',),
                            Text('kjnbdjknd kojedkewjdkwejdwjkjnhkjhnknhkjhkh ghfdhtr fghtfhy rtrhr ntrhreh rtnj werwe dfgbedrge thtrhntr',overflow: TextOverflow.fade,),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    Icon(Icons.menu)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
