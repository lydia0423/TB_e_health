import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LiveChat extends StatefulWidget {
  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];

  ScrollController _controller = ScrollController();

  //in flask app we defined the route for our query -> bot
  static const String BOT_URL = 'https://tb-e-health-chatbot.herokuapp.com/bot';
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: AnimatedList(
                      reverse: false,
                      key: _listKey,
                      controller: _controller,
                      initialItemCount: _data.length,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        return buildItem(_data[index], animation, index);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // text field and icon field
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorFiltered(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10.0),
                    child: TextField(
                      onEditingComplete:
                          (_controller.hasClients) ? jumper(_controller) : null,
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
                        getResponse();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
            Timer(Duration(milliseconds: 300), () => jumper(_controller));
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
    axis: Axis.vertical,
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

jumper(ScrollController _controller) {
  print('onTap: jump ?');
  print('jumpTo: ${_controller.position.maxScrollExtent}');
  Timer(Duration(milliseconds: 300),
      () => _controller.jumpTo(_controller.position.maxScrollExtent));
}
