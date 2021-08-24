import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/Screens/chatbot/live_chat.dart';
import 'package:tb_e_health/Screens/navigations.dart';
import 'package:tb_e_health/Screens/tb_info/tb_dots.dart';
import 'package:tb_e_health/Screens/tb_info/tb_overview.dart';
import 'package:tb_e_health/Screens/tb_info/tb_side_effect_info.dart';
import 'package:tb_e_health/Screens/tb_info/tb_symptom_info.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 35.0,
              ),
              onPressed: () => Get.to(() => Navigations())),
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Overview()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SymptomsInfo()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SideEffectInfo()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DotsTherapyInfo()),
                  );
                },
                child: Text(
                  'Dots Therapy',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LiveChat()),
                  );
                },
                child: Text(
                  'Live Chat',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ), //parameters of Button class
            ),
          ],
        ),
      ),
    );
  }
}
