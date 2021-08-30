import 'package:flutter/material.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/services/auth_service.dart';

import 'daily_progress_board.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return FutureBuilder(
        future: myActiveUser(),
        builder: (BuildContext context, AsyncSnapshot<ActiveUser> user) {
          if (user.hasData) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return LiveChat();
                })),
                child: Icon(Icons.live_help_outlined),
                backgroundColor: Colors.black,
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MY PERSONAL PROFILE',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.logout,
                            size: 30.0,
                          ),
                          onTap: () => _auth.signOut(),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 10.0),
                        child: (user.data!.avatar.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.data!.avatar),
                                radius: 70.0,
                              )
                            : CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/Images/user_profile.png"),
                                radius: 70.0,
                              ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${user.data!.name}",
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 10.0),
                          Text(
                            "Age: ${user.data!.age}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Gender: ${user.data!.gender}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      height: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Health Information: ${user.data!.healthInfo}",
                              style: TextStyle(fontSize: 18.0)),
                          Text("Address: ${user.data!.address}",
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                          Container(
                            width: 320,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Do you wish to turn on reminders for VDOTS treatment?",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Switch(
                                  value: user.data!.notificationPreference,
                                  onChanged: (value) {
                                    setState(() {
                                      user.data!.notificationPreference = value;
                                    });
                                  },
                                  activeTrackColor: Colors.black,
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 130.0),
                    child: OutlinedButton(
                        onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DailyProgressBoardScreen();
                            })),
                        child: Icon(
                          Icons.analytics_rounded,
                          size: 50.0,
                          color: Colors.black,
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(30.0),
                          elevation: 1.5,
                        )),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "My DOTS Therapy Progress",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
