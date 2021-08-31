import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/models/delivery_request.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/utils.dart';
import 'package:uuid/uuid.dart';

class DrugRequestScreen extends StatelessWidget {
  final DateTime dateFrom;
  final DateTime dateUntil;

  DrugRequestScreen({
    required this.dateFrom,
    required this.dateUntil,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:a ').format(now);

    return Scaffold(
      appBar: CommonAppBar(title: 'Confirm Order'),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   toolbarHeight: 80,
      //   backgroundColor: Colors.transparent,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 20.0, left: 30.0),
      //     child: IconButton(
      //       icon: new Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.black,
      //         size: 35.0,
      //       ),
      //       onPressed: () => Get.back(),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          ' to be delivered directly to your house instead of coming to UMMC to collect your medication. Please confirm your order at least 1 week before your medications finish.',
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Use of Service By',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height:20.0),
                Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10.0,),
                    Text('$formattedDate'),
                  ],
                ),

                SizedBox(height:20.0),
                ElevatedButton(
                  onPressed: () async {
                    var now = DateTime.now();
                    ActiveUser user = await myActiveUser();
                    await createDrugDeliveryRequest(DrugDeliveryRequest(
                      type: OrderType.Delivery,
                      id: Uuid().v4(),
                      requestDate: '${now.year}-${now.month}-${now.day}',
                      // TODO: get user start and end
                      userId: user.userId,
                      userName: user.name,
                      userAddress: user.address,
                      therapyEndDate: user.therapyEndDate,
                      therapyStartDate: user.therapyStartDate,
                    ));
                    // Get.back();
                    Navigator.pop(context, "Bar");
                  },
                  child: SizedBox(
                    height: 40,
                    width: 240,
                    child: Center(child: Text('Confirm Order')),
                  ),
                ),

                SizedBox(height:20.0),

                TextButton(
                  onPressed: () async {
                    var now = DateTime.now();
                    ActiveUser user = await myActiveUser();
                    await createDrugDeliveryRequest(DrugDeliveryRequest(
                      type: OrderType.Pickup,
                      id: Uuid().v4(),
                      requestDate: '${now.year}-${now.month}-${now.day}',
                      // TODO: get user start and end
                      userId: user.userId,
                      userName: user.name,
                      userAddress: user.address,
                      therapyEndDate: user.therapyEndDate,
                      therapyStartDate: user.therapyStartDate,
                    ));
                    // Get.back();
                    Navigator.pop(context, "Bar");
                  },
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
              ],
            ),
          ),

        ],
      ),
    );
  }
}
