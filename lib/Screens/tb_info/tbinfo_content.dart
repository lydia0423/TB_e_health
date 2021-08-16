import 'package:flutter/material.dart';
import 'package:tb_e_health/Screens/tb_info/tb_overview.dart';
import 'package:tb_e_health/Screens/tb_info/tb_side_effect_info.dart';
import 'package:tb_e_health/Screens/tb_info/tb_dots.dart';
import 'package:tb_e_health/Screens/tb_info/tb_symptom_info.dart';

class TbInfo extends StatelessWidget {
  const TbInfo({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Tb Info',
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:70, //height of button
                width:280, //width of button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          primary: Colors.blue, //background color of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(30)
                          ),
                          padding: EdgeInsets.all(20),
                    ),
                  onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Overview()),
                        );
                      },
                      child: Text('Overview of TB',
                        style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),//parameters of Button class
                ),
              SizedBox(height: 60.0),

              SizedBox(
                height:70, //height of button
                width:280, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background color of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SymptomsInfo()),
                    );
                  },
                  child: Text('Symptoms of TB',
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),//parameters of Button class
              ),
              SizedBox(height: 60.0),

              SizedBox(
                height:70, //height of button
                width:280, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background color of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SideEffectInfo()),
                    );
                  },
                  child: Text('Side Effects of TB',
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),//parameters of Button class
              ),
              SizedBox(height: 60.0),

              SizedBox(
                height:70, //height of button
                width:280, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background color of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DotsTherapyInfo()),
                    );
                  },
                  child: Text('Dots Therapy',
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),//parameters of Button class
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}