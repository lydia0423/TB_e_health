import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/navigations.dart';
import 'package:tb_e_health/screens/tb_info/tb_dots.dart';
import 'package:tb_e_health/screens/tb_info/tb_overview.dart';
import 'package:tb_e_health/screens/tb_info/tb_side_effect_info.dart';
import 'package:tb_e_health/screens/tb_info/tb_symptom_info.dart';

class QnA extends StatefulWidget {
  @override
  _QnAState createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70, //height of button
              width: 280, //width of button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, //background color of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: Overview(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                },
                child: Text(
                  'Overview of TB',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ), //parameters of Button class
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 70, //height of button
              width: 280, //width of button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, //background color of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: SymptomsInfo(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                },
                child: Text(
                  'Symptoms of TB',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ), //parameters of Button class
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 70, //height of button
              width: 280, //width of button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, //background color of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: SideEffectInfo(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                },
                child: Text(
                  'Side Effects of TB',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ), //parameters of Button class
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 70, //height of button
              width: 280, //width of button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, //background color of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: DotsTherapyInfo(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                },
                child: Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ), //parameters of Button class
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
