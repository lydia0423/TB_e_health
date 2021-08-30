import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/hello_calendar.dart';
import 'package:tb_e_health/Models/video_uploaded.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/utils.dart';

import '../utils.dart';

class DailyProgressBoardScreen extends StatefulWidget {
  @override
  _DailyProgressBoardScreenState createState() =>
      _DailyProgressBoardScreenState();
}

class _DailyProgressBoardScreenState extends State<DailyProgressBoardScreen> {
  Map<DateTime, bool> dates = {};

  @override
  void initState() {
    super.initState();
    _loadSubmission();
  }

  _loadSubmission() async {
    DocumentSnapshot<dynamic> docsnap = await getActiveUser();
    final ActiveUser activeUser = ActiveUser.fromJson(docsnap.data());
    print(activeUser.userId);
    List<VideoUploaded> submissions =
        await findVideoUploadedOfUser(activeUser.userId);
    print('_loadSubmission: size : ${submissions.length}');
    for (var submission in submissions) {
      DateTime doneDate = new DateTime(submission.dateTime.year,
          submission.dateTime.month, submission.dateTime.day);
      dates[doneDate] = true;
    }
    setState(() {
      this.dates = dates;
    });
    print('_loadSubmission: $dates');
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    return Scaffold(
      appBar: CommonAppBar(title: 'My DOTS Therapy Progress'),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return LiveChat();
      //   })),
      //   child: Icon(Icons.live_help_outlined),
      //   backgroundColor: Colors.black,
      // ),
      body: ListView(
        children: [
          HelloCalendar(
            year: today.year,
            month: today.month,
            // TODO: get from state
            from: DateTime(2021, 8, 5),
            to: DateTime(2021, 8, 25),
            until: DateTime(2021, 12, 31),
            dates: dates,
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Legend',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: HelloGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Video Submitted'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: HelloRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Video Not Submitted'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          color: HelloYellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Pending'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
