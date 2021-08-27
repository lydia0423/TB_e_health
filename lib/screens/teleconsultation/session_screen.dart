import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';

class SessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('Teleconsultation Session'),
      ),
    );
  }
}
