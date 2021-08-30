import 'package:firebase_auth/firebase_auth.dart';
import 'package:tb_e_health/Custom%20Widgets/hello_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Models/video_uploaded.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';

import 'package:tb_e_health/utils.dart';

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
    List<VideoUploaded> submissions =
        await findVideoUploadedOfUser(FirebaseAuth.instance.currentUser!.uid);
    for (var submission in submissions) {
      dates[DateTime.now()] = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    // TODO: get state
    return Scaffold(
      // TODO: primary color
      appBar: CommonAppBar(title: ''),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          HelloCalendar(
            year: today.year,
            month: today.month,
            // TODO: get from state
            from: DateTime(2021, 8, 5),
            to: DateTime(2021, 8, 30),
            until: DateTime(2021, 8, 26),
            dates: dates,
          ),
        ],
      ),
    );
  }
}
