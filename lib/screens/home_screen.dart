import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tb_e_health/Models/active_user.dart';
import 'package:tb_e_health/common/constants.dart';
import 'package:tb_e_health/screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/screens/video_upload.dart';
import 'package:tb_e_health/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/drug_delivery/drug_request_list.dart';
import 'package:tb_e_health/side_effect.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _uploadWidget() => SizedBox(
      height: 200,
      width: 200,
      child: GestureDetector(
          onTap: () => pushNewScreen(
                context,
                screen: UploadVideo(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
              ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Assets.images.iconCloud.svg(),
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
      body: FutureBuilder(
          future: myActiveUser(),
          builder: (BuildContext context, AsyncSnapshot<ActiveUser> user) {
            if (user.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Center(
                      child: Text('Hello!',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        user.data!.name,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  _uploadWidget(),
                  Text(
                    'Upload Video',
                    style: TextStyle(fontSize: Constants.titleFs),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _featureButton(
                        child: Assets.images.iconCart.svg(height: 30),
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: DrugRequestListScreen(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                          );
                        },
                        title: 'Drug Delivery',
                      ),
                      _featureButton(
                        child: Assets.images.iconNote.svg(height: 80),
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
                  SizedBox(height: 30.0)
                ],
              );
            } else {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              );
            }
          }),
    );
  }
}
