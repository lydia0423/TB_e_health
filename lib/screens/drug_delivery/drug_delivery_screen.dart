import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/drug_delivery/drug_request_list.dart';
import 'package:tb_e_health/screens/drug_delivery/faq_screen.dart';

class DrugDeliveryScreen extends StatelessWidget {
  Widget _rowSelection(String logo, String title, void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Icon(Icons.help),
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          SizedBox(
            height: 16,
          ),
          _rowSelection('', 'Drug Delivery', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DrugRequestListScreen(),
                settings: RouteSettings(name: 'DrugRequestListScreen')));
          }),
          _rowSelection('', 'Speak to a Nurse', () {}),
          _rowSelection('', 'FAQs', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FAQ(),
                settings: RouteSettings(name: 'FQA')));
          }),
        ],
      ),
    );
  }
}