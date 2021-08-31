import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/hello_calendar.dart';
import 'package:tb_e_health/Models/video_uploaded.dart';
import 'package:tb_e_health/models/active_user.dart';
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

  Future<ActiveUser> _loadUserData() async {
    final ActiveUser user = await myActiveUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    return Scaffold(
      appBar: CommonAppBar(title: 'My VOTS Therapy Progress'),
      body: FutureBuilder<ActiveUser>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error on loading user data');
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                HelloCalendar(
                  year: today.year,
                  month: today.month,
                  // TODO: get from state
                  from: DateTime.parse(snapshot.data!.therapyStartDate),
                  to: DateTime.parse(snapshot.data!.therapyEndDate),
                  until: DateTime(2021, 9, 22),
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
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
