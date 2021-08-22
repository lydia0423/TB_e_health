import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tb_e_health/Models/delivery_request.dart';
import 'package:tb_e_health/Screens/drug_delivery/request_display_card.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 196,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(), 
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Drug Delivery Service',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ]
                    ),
                  ),
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
                    future: findDrugDeliveryRequestOfUser(
                      FirebaseAuth.instance.currentUser!.uid,
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
                          if (snapshot.data == null || snapshot.data!.length == 0) {
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
                            }
                          );
                        }
                      }
                      return Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  ),
                  // history
                  FutureBuilder<List<DrugDeliveryRequest>>(
                    future: findDrugDeliveryRequestOfUser(
                      FirebaseAuth.instance.currentUser!.uid,
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
                          if (snapshot.data == null || snapshot.data!.length == 0) {
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
                            }
                          );
                        }
                      }
                      return Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _requestNewDrugDelivery(context),
        child: Icon(Icons.add),
      ),
    );
  }
}