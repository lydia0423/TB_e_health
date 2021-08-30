import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tb_e_health/models/delivery_request.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/drug_delivery/request_display_card.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';

import 'drug_request_screen.dart';

class DrugRequestListScreen extends StatefulWidget {
  @override
  _DrugRequestListScreenState createState() => _DrugRequestListScreenState();
}

class _DrugRequestListScreenState extends State<DrugRequestListScreen> {
  // TabController tabController = TabController();

  _requestNewDrugDelivery(BuildContext context) {
    Get.to(() => DrugRequestScreen(
          dateFrom: DateTime(2021, 9, 1),
          dateUntil: DateTime(2021, 9, 15),
        ));
  }

  @override
  Widget build(BuildContext context) {
    print('HERE');
    print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: CommonAppBar(title: 'Drug Delivery Service'),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              // height: 196,
              // decoration: BoxDecoration(
              //   color: Theme.of(context).primaryColor,
              //   borderRadius:
              //       BorderRadius.only(bottomLeft: Radius.circular(50)),
              // ),
              child: Column(
                children: [
                  // Expanded(
                  //   child: Row(children: [
                  //     IconButton(
                  //       onPressed: () => Navigator.of(context).pop(),
                  //       icon: Icon(Icons.arrow_back, color: Colors.white),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Drug Delivery Service',
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ]),
                  // ),
                  TabBar(
                    tabs: [
                      Tab(
                        text: 'Order',
                      ),
                      Tab(
                        text: 'History',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // order
                  FutureBuilder<List<DrugDeliveryRequest>>(
                      future: findDrugDeliveryRequestOfActiveUser(
                        myActiveUser(),
                        history: false,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: SizedBox(
                                child: Text('Facing Error'),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            if (snapshot.data == null ||
                                snapshot.data!.length == 0) {
                              return Center(
                                child: SizedBox(
                                  child: Text('No request found'),
                                ),
                              );
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return RequestDisplayCard(
                                    snapshot.data![index],
                                  );
                                });
                          }
                        }
                        return Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                  // history
                  FutureBuilder<List<DrugDeliveryRequest>>(
                      future: findDrugDeliveryRequestOfActiveUser(
                        myActiveUser(),
                        history: true,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: SizedBox(
                                child: Text('Facing Error'),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            if (snapshot.data == null ||
                                snapshot.data!.length == 0) {
                              return Center(
                                child: SizedBox(
                                  child: Text('No history found'),
                                ),
                              );
                            }
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return RequestDisplayCard(
                                    snapshot.data![index],
                                  );
                                });
                          }
                        }
                        return Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => _requestNewDrugDelivery(context),
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LiveChat();
              })),
              child: Icon(Icons.live_help_outlined),
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
