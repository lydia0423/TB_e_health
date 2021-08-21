import 'package:flutter/material.dart';

class DrugDeliveryScreen extends StatelessWidget {

  Widget _rowSelection(String logo, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
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
          _rowSelection('', 'Drug Delivery'),
          _rowSelection('', 'Speak to a Nurse'),
          _rowSelection('', 'FAQs'),
        ],
      ),
    );
  }
}