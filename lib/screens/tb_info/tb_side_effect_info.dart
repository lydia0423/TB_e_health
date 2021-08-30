import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';

class SideEffectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Side Effects of Tuberculosis'),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Like all medicines, the medicine you take to cure TB infection can have side effects.\n\n'
                      'Tell your doctor right away if you have:\n\n'
                      '- Dizziness when sitting, standing or lying down.\n'
                      '- Less appetite\n- Stomach upset, nausea/vomiting\n- Pain in your lower chest or heartburn.\n- Flu-like symptoms with fever\n'
                      '- Severe tiredness or weakness.\n- Fevers or chills.\n- Severe diarrhea or light colored stools (poop).\n'
                      '- Brown, tea-colored, or cola-colored urine.\n\n'
                      'Read more about the side effects of TB treatment OR schedule a call with our staff. \n',
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ),
      ),
    );
  }
}
