import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/Models/active_user.dart';
import 'package:tb_e_health/Screens/shared/common_app_bar.dart';
import 'package:tb_e_health/Screens/teleconsultation/scheduler_screen.dart';

import 'gen/assets.gen.dart';

/// This is the stateful widget that the main application instantiates.
class SideEffect extends StatefulWidget {
  const SideEffect({Key? key}) : super(key: key);

  @override
  State<SideEffect> createState() => _SideEffectState();
}

/// This is the private State class that goes with SideEffect.
class _SideEffectState extends State<SideEffect> {
  TextEditingController otherCtrl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isChecked = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false,
      isChecked6 = false,
      isChecked7 = false,
      isChecked8 = false,
      isChecked9 = false,
      isChecked10 = false,
      isChecked11 = false,
      isChecked12 = false,
      isChecked13 = false,
      isChecked14 = false,
      isChecked15 = false,
      isChecked16 = false,
      isChecked17 = false;
  String otherDescription = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Side Effects'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 500,
              child: (Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 10.0),
                child: Text(
                  'What side effects are you experiencing?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ),
            Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    CheckboxListTile(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Eyesight Worsening (EYE)"),
                    ),
                    CheckboxListTile(
                      value: isChecked2,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked2 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Yellowing of Eyes (EYE)"),
                    ),
                    CheckboxListTile(
                      value: isChecked3,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Ringing Sound (EARS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked4,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked4 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Tingling Sensation (ARMS/LEGS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked5,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked5 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Bruises (ARMS/LEGS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked6,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked6 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Bleeding (ARMS/LEGS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked7,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked7 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Joint Pains (ARMS/LEGS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked8,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked8 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Rashes (ARMS/LEGS)"),
                    ),
                    CheckboxListTile(
                      value: isChecked9,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked9 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Mood Worsening/Changes (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked10,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked10 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Weight Loss (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked11,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked11 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Tiredness (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked12,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked12 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Seizures (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked13,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked13 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Itchiness (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked14,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked14 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Dark Urine (URINE)"),
                    ),
                    CheckboxListTile(
                      value: isChecked15,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked15 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Orange Urine (URINE)"),
                    ),
                    CheckboxListTile(
                      value: isChecked16,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked16 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                          "Stomach Pain (particularly right upper area) (GENERAL)"),
                    ),
                    CheckboxListTile(
                      value: isChecked17,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked17 = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("OTHERS (please describe)"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65.0),
                      child: TextFormField(
                        validator: (v) => v!.isEmpty ? 'Enter an email' : null,
                        onChanged: (v) {
                          setState(() {
                            otherDescription = v;
                          });
                        },
                        controller: otherCtrl,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ]),
                )),
            Container(
              height: 80,
              width: 500,
              child: (Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0),
                child: Text(
                  'When did these side effects start?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.calendar_today),
                    tooltip: 'Click to View Calendar',
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    hoverColor: Colors.white,
                    splashColor: Colors.white,
                    highlightElevation: 20,
                    mini: false,
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate, // Refer step 1
                          firstDate: DateTime.now().subtract(Duration(days: 6)),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                          });
                      },
                      child: Text("${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    height: 50, //height of button
                    width: 200, //width of button
                  ),
                ],
              ),
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50, //height of button
                  width: 170, //width of button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[850], //background color of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      submitForm(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ), //parameters of Button class
                )
              ],
            )),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    height: 20, //height of button
                    width: 200, //width of button
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              width: 500,
              child: (Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 10.0),
                child: Text(
                  'Tap to book a teleconsultation',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: SchedulerScreen(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                          );
                        },
                        child: Assets.images.iconSupport.svg(height: 30),
                        tooltip: 'Click to Call',
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        hoverColor: Colors.white,
                        splashColor: Colors.white,
                        highlightElevation: 20,
                        mini: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Teleconsultation',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    height: 70, //height of button
                    width: 200, //width of button
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future submitForm(BuildContext context) async {
    ActiveUser currentUser = await myActiveUser();
    await FirebaseFirestore.instance.collection("UserSideEffect").add({
      'UserId': currentUser.userId,
      'UserSideEffectStartDate': selectedDate.toString(),
      'Eyesight Worsening (EYE)': isChecked,
      'Yellowing of Eyes (EYE)': isChecked2,
      'Ringing Sound (EARS)': isChecked3,
      'Tingling Sensation (ARMS/LEGS)': isChecked4,
      'Bruises (ARMS/LEGS)': isChecked5,
      'Bleeding (ARMS/LEGS)': isChecked6,
      'Joint Pains (ARMS/LEGS)': isChecked7,
      'Rashes (ARMS/LEGS)': isChecked8,
      'Mood Worsening/Changes (GENERAL)': isChecked8,
      'Weight Loss (GENERAL)': isChecked9,
      'Tiredness (GENERAL)': isChecked10,
      'Seizures (GENERAL)': isChecked11,
      'Itchiness (GENERAL)': isChecked12,
      'Dark urine (URINE)': isChecked13,
      'Orange urine (URINE)': isChecked14,
      'Stomach pain (particularly right upper area) (GENERAL)': isChecked15,
      'Other': otherDescription,
    }).catchError((onError) {
      print(onError);
    });
    customAlertDialog(context,
        title: 'Reminder', content: 'Sucessfully submit the form!');
  }
}
