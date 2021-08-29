import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.requestDate, 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Order: ${request.id}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Status: ${request.status}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class RequestDetailDisplayCard extends StatelessWidget {
  final DrugDeliveryRequest request;

  RequestDetailDisplayCard(this.request);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              request.requestDate, 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Order: ${request.id}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),
            for (var item in request.item) 
              Text(
                item, 
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),    
            SizedBox(height: 12),
            Text(
              'Prescription Approved by: ${request.approvedBy}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12), 
            Text(
              'Dates for Medication:\n${request.therapyStartDate} - ${request.therapyEndDate}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Status: ${request.status}', 
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ]
        ),
      ),
    );
  }
}