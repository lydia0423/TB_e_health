import 'package:flutter/material.dart';
import 'package:tb_e_health/Screens/drug_delivery/drug_request_list.dart';

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
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: SizedBox(
                width: 100, height: 100,
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
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 16,),
          _rowSelection('', 'Drug Delivery', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DrugRequestListScreen())
            );
          }),
          _rowSelection('', 'Speak to a Nurse', () {}),
          _rowSelection('', 'FAQs', () {}),
        ],
      ),
    );
  }
}