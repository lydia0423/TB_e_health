import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/ques_ans.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text(
            'Overview of Tuberculosis',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LiveChat();
          })),
          child: Icon(Icons.live_help_outlined),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Tuberculosis (TB) is a bacterial infection spread through inhaling tiny droplets from the coughs or sneezes of an infected person.'
                      '\n\nIt mainly affects the lungs, but it can affect any part of the body, including the tummy (abdomen), glands, bones and nervous system.'
                      '\n\nTB is a potentially serious condition, but it can be cured if it is treated with the right antibiotics',
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ));
  }
}
