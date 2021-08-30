import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: CommonAppBar(title: ''),
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
            decoration: BoxDecoration(
              color: HelloRed,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                  text:
                      'By clicking ‘Confirm Order’, the DOTS staff will understand that you wish for your DOTS medications from ',
                  children: [
                    TextSpan(
                      text:
                          '${dateFrom.day}/${dateFrom.month}/${dateFrom.year}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: ' to ',
                    ),
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
          Text('Confirm Use of Service By'),
          Row(
            children: [
              Icon(Icons.calendar_today),
              Text('${DateTime.now()}'),
            ],
          ),
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
              Get.back();
            },
            child: SizedBox(
              height: 40,
              width: 240,
              child: Center(child: Text('Confirm Order')),
            ),
          ),
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
              Get.back();
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
    );
  }
}
