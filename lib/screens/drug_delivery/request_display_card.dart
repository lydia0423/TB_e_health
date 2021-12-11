import 'package:flutter/material.dart';
import 'package:tb_e_health/common/constants.dart';
import 'package:tb_e_health/models/delivery_request.dart';

class RequestDisplayCard extends StatelessWidget {
  final DrugDeliveryRequest request;

  RequestDisplayCard(this.request);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            request.requestDate,
            style: TextStyle(
              fontSize: Constants.textFs,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Order: ${request.id}',
            style: TextStyle(
              fontSize: Constants.textFs,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Status: ${request.status}',
            style: TextStyle(
              fontSize: Constants.textFs,
              color: Colors.grey,
            ),
          ),
        ]),
      ),
    );
  }
}
