import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tb_e_health/custom_widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/delivery_request.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:uuid/uuid.dart';

class DrugRequestScreen extends StatelessWidget {
  final DateTime dateFrom;
  final DateTime dateUntil;
  final List<DrugDeliveryRequest> ongoingRequests;

  DrugRequestScreen({
    required this.dateFrom,
    required this.dateUntil,
    required this.ongoingRequests,
  });

  _choiceButtons(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:a ').format(now);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Confirm Use of Service By',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today),
                SizedBox(
                  width: 10.0,
                ),
                Text('$formattedDate'),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          // If the user click on the 'Pick Up Themselves', the confirm button should be disable and show the pick up date. The confirm button will be enable when they already collect their medication
          ElevatedButton(
            onPressed: () async {
              var now = DateTime.now();
              ActiveUser user = await myActiveUser();
              await createDrugDeliveryRequest(DrugDeliveryRequest(
                type: OrderType.Delivery,
                id: Uuid().v4(),
                requestDate: DateFormat('yyyy-MM-dd').format(now),
                userId: user.userId,
                userName: user.name,
                userAddress: user.address,
                therapyEndDate: user.therapyEndDate,
                therapyStartDate: user.therapyStartDate,
              ));
              // Update user TherapyUntilDate
              updateTherapyUntilDate(dateUntil);
              // Get.back();
              Navigator.pop(context);
            },
            child: SizedBox(
              height: 40,
              width: 180,
              child: Center(child: Text('Confirm Order')),
            ),
          ),
          SizedBox(height: 20.0),
          TextButton(
            //change button style same with the confirm button
            onPressed: () async {
              var now = DateTime.now();
              ActiveUser user = await myActiveUser();
              await createDrugDeliveryRequest(DrugDeliveryRequest(
                type: OrderType.Pickup,
                id: Uuid().v4(),
                requestDate: DateFormat('yyyy-MM-dd').format(now),
                userId: user.userId,
                userName: user.name,
                userAddress: user.address,
                therapyEndDate: user.therapyEndDate,
                therapyStartDate: user.therapyStartDate,
              ));
              // Update user TherapyUntilDate
              updateTherapyUntilDate(dateUntil);
              // Get.back();
              Navigator.pop(context);
              customAlertDialog(context,
                  title: 'Self Pickup Confirmed',
                  content:
                      'Please come to hospital on 2021-09-10 to collect your medication.');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: SizedBox(
                height: 40,
                width: 240,
                child: Center(
                    child: Text(
                  'I’ll Come To Clinic For Next Prescription',
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _infoOnRequest(BuildContext context) {
    var request = ongoingRequests[0];

    var oneDayAfter =
        DateTime.parse(request.requestDate).add(Duration(days: 1));
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              request.type == OrderType.Delivery
                  ? 'Delivery will be sent on\n${DateFormat('yyyy-MM-dd').format(oneDayAfter)}'
                  : 'Please pick up on\n${DateFormat('yyyy-MM-dd').format(oneDayAfter)}',
              textAlign: TextAlign.center,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Confirm Order'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey)),
            padding: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  text:
                      'By clicking ‘Confirm Order’, the DOTS staff will understand that you wish for your DOTS medications from ',
                  children: [
                    TextSpan(
                      text:
                          '${dateFrom.day}/${dateFrom.month}/${dateFrom.year}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                        text: ' to ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text:
                          '${dateUntil.day}/${dateUntil.month}/${dateUntil.year}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' to be delivered directly to your house instead of coming to UMMC to collect your medication.',
                    ),
                  ]),
            ),
          ),
          Text(
            'Confirm Use of Service By',
            style: TextStyle(fontSize: 18),
          ),
          // If the user click on the 'Pick Up Themselves', the confirm button should be disable and show the pick up date. The confirm button will be enable when they already collect their medication
          if (ongoingRequests.length == 0)
            _choiceButtons(context)
          else
            _infoOnRequest(context),
        ],
      ),
    );
  }
}
