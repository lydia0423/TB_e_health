import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tb_e_health/Models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/drug_delivery/drug_delivery_screen.dart';
import 'package:tb_e_health/screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/screens/video_upload.dart';
import 'package:tb_e_health/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/side_effect.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _uploadWidget() => SizedBox(
      height: 300,
      width: 300,
      child: GestureDetector(
          onTap: () => pushNewScreen(
                context,
                screen: UploadVideo(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
              ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Assets.images.iconCloud.svg(),
              ),
            ),
          )));

  Widget _featureButton({
    required Widget child,
    required void Function()? onTap,
    required String title,
  }) =>
      SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: Center(
                    child: child,
                  ),
                ),
              ),
              onTap: onTap,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
          future: myActiveUser(),
          builder: (BuildContext context, AsyncSnapshot<ActiveUser> user) {
            if (user.hasData) {
              return ListView(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text('Hello!',
                            style: TextStyle(
                                fontSize: 45.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        user.data!.name,
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  _uploadWidget(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Upload Video',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _featureButton(
                          child: Assets.images.iconCart.svg(height: 30),
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: DrugDeliveryScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                            );
                          },
                          title: 'Drug Delivery',
                        ),
                        _featureButton(
                          child: Assets.images.iconNote.svg(height: 30),
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: SideEffect(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                            );
                          },
                          title: 'Side Effects',
                        ),
                        _featureButton(
                          child: Assets.images.iconSupport.svg(height: 30),
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: SchedulerScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                            );
                          },
                          title: 'Tele Consultation',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0)
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          }),
    );
  }
}
