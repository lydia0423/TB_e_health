import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Models/user.dart';
import 'package:tb_e_health/Screens/chatbot/live_chat.dart';

import 'daily_progress_board.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 70.0, 20.0, 10.0),
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
                          onTap: () => logout(),
                        )
                      ],
                    ),
                  ),
                  Row(
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
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 29.0, 8.0),
                            child: Row(
                              children: [
                                Text("Name: ",
                                    style: TextStyle(fontSize: 18.0)),
                                Text(
                                  user.data!.name,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 8.0, 63.0, 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Age: ",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  user.data!.age,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Gender: ",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  user.data!.gender,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: [
                        Text("Health Information: ",
                            style: TextStyle(fontSize: 18.0)),
                        Text(user.data!.healthInfo,
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: [
                        Text("Address: ", style: TextStyle(fontSize: 18.0)),
                        Text(user.data!.address,
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(35.0, 10.0, 10.0, 10.0),
                        child: Container(
                          width: 320,
                          child: Text(
                            "Do you wish to turn on reminders for VDOTS treatment?",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(28.0, 0.0, 10.0, 10.0),
                        child: Switch(
                          value: user.data!.notificationPreference,
                          onChanged: (value) {
                            setState(() {
                              user.data!.notificationPreference = value;
                            });
                          },
                          activeTrackColor: Colors.black,
                          activeColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                      onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DailyProgressBoardScreen();
                          })),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
                        child: Icon(
                          Icons.analytics_rounded,
                          size: 50.0,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        backgroundColor: Colors.white,
                        elevation: 1.5,
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "See Daily Progress",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  //? Logout function
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/", ModalRoute.withName("/"));
  }
}
