import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  Future getAllFaqs() async {
    await Firebase.initializeApp();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn =
        await firestore.collection("FAQ").orderBy("FaqTitle").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 35.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: FutureBuilder(
          future: getAllFaqs(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LinearProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 90.0, 0.0, 10.0),
                    child: Text(
                      'FAQ',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return Container(
                          child: Card(),
                        );
                      }),
                ],
              );
            }
          }),
    );
  }
}
