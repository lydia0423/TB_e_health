import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/utils.dart';

class DrugRequestScreen extends StatelessWidget {

  final DateTime dateFrom;
  final DateTime dateUntil;

  DrugRequestScreen({
    required this.dateFrom,
    required this.dateUntil,
  });

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
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HelloRed,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                text: 'By clicking ‘Confirm Order’, the DOTS staff will understand that you wish for your DOTS medications from ',
                children: [
                  TextSpan(
                    text: '${dateFrom.day}/${dateFrom.month}/${dateFrom.year}',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: ' to ',
                  ),
                  TextSpan(
                    text: '${dateUntil.day}/${dateUntil.month}/${dateUntil.year}',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: ' to be delivered directly to your house instead of coming to UMMC to collect your medication. Please confirm your order at least 1 week before your medications finish.',
                  ),
                ]
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text('Confirm Use of Service By'),
          Row(
            children: [
              Icon(Icons.calendar_today),
              Text('${DateTime.now()}'),
            ],
          ),
          ElevatedButton(
            onPressed: () {}, 
            child: Text('Confirm Order'),
          ),
          TextButton(
            onPressed: () {}, 
            child: Text('I’ll Come To Clinic For Next Prescription'),
          ),
        ],
      ),
    );
  }
}