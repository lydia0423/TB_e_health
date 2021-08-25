import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/Screens/ques_ans.dart';
import 'package:http/http.dart' as http;

class LiveChat extends StatefulWidget {
  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];

  //in flask app we defined the route for our query -> bot
  static const String BOT_URL = 'https://tb-e-health-chatbot.herokuapp.com/bot';
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30.0),
          child: IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 35.0,
              ),
              onPressed: () => Get.back()),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 680,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return buildItem(_data[index], animation, index);
              },
            ),
          ),
          SizedBox(height: 60.0),
          // text field and icon field
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      hintText: 'Type your message here ...',
                      fillColor: Colors.white,
                    ),
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (msg) {
                      this.getResponse();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// response
  void getResponse() {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text);
      var client = getClient();
      try {
        client.post(
          Uri.parse(BOT_URL),
          body: {"query": queryController.text},
        )..then((response) {
            print(response.body);
            Map<String, dynamic> data = jsonDecode(response.body);
            insertSingleItem(data['response'] + "<bot>");
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState!.insertItem(_data.length - 1);
  }

  //creating client first
  http.Client getClient() {
    return http.Client();
  }
}

//Build item widget which will take context, animation and index as parameter
Widget buildItem(String item, Animation<double> animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20.0, bottom: 10.0),
          child: Bubble(
            child: Text(
              item.replaceAll("<bot>", ""),
              style: TextStyle(color: mine ? Colors.white : Colors.black),
            ),
            color: mine ? Colors.blue : Colors.grey[200],
            padding: BubbleEdges.all(10),
          ),
        ),
      ),
    ),
  );
}
