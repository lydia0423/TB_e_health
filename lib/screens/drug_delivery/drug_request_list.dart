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
  _requestNewDrugDelivery(BuildContext context) async {
    String received = await Navigator.push(context, MaterialPageRoute(builder: (_) => DrugRequestScreen(
      dateFrom: DateTime(2021, 9, 1),
      dateUntil: DateTime(2021, 9, 15),
    )));
    setState(() {
      // so that the page refresh, and show the newly added record.
    });
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
              child: Column(
                children: [
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
                            } else {
                              print('im here!');
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return RequestDisplayCard(
                                      snapshot.data![index],
                                    );
                                  });
                            }
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
            FloatingActionButton.extended(
              onPressed: () => _requestNewDrugDelivery(context),
              label: Text('Create Order'),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
