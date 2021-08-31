import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/navigations.dart';
import 'package:tb_e_health/screens/ques_ans.dart';

class DotsTherapyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text(
          'VOTS Therapy',
        ),
      ),
      // AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 20.0, left: 30.0),
      //     child: IconButton(
      //       icon: new Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.black,
      //         size: 35.0,
      //       ),
      //       onPressed: () => Navigator.pop(context),
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return LiveChat();
      //   })),
      //   child: Icon(Icons.live_help_outlined),
      //   backgroundColor: Colors.black,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 100,
            //   width: 500,
            //   child: Center(
            //     child: Text(
            //       'Dots Therapy',
            //       style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'If you have TB disease, you will take several medicines when you start your treatment to kill the TB germs in your body. They are:\n\n'
                    '1. Isoniazid (i-so-ni-a-zid)\n2. Rifampin (ri-fam-pin)\n3. Ethambutol (eth-am-byoo-tol)\n4. Pyrazinamide (peer-a-zin-a-mide)\n\n'
                    'What is “VOTS”?\n\n'
                    'DOT is short for Directly Observed Therapy. Depending on your medicine plan, a healthcare worker will meet with you every day '
                    'or a few times a week to watch you take your TB pills. He or she will bring you your pills at the place and time  most easy for you.'
                    'This can help you stay with your medicine plan. \n',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
