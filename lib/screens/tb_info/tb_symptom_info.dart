import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/ques_ans.dart';

class SymptomsInfo extends StatelessWidget {
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
              onPressed: () => Navigator.pop(context),
            ),
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
              height: 100,
              width: 500,
              child: Center(
                child: Text(
                  'Symptoms of Tuberculosis',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Typical symptoms of TB include:\n'
                      '- a persistent cough that lasts more than 3 weeks and usually brings up phlegm, which may be bloody\n'
                      '- Weight loss\n- Night sweats\n- High Temperature\n- Tiredness and Fatigue\n'
                      '- Lost of appetite\n- Swellings in the neck\n\n'
                      'You should see a GP if you have a cough that lasts more than 3 weeks or you cough up blood.\n',
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ));
  }
}
