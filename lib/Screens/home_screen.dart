import 'package:tb_e_health/gen/assets.gen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _uploadWidget() =>
      SizedBox(
        height: 300,
        width: 300,
        child: GestureDetector(
          onTap: () {}, // TODO: 
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Assets.images.iconCloud.svg(),
            ),
          ),
        ),
      );
  
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
                  height: 64, width: 64,
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
      // appBar: HelloAppBar(),
      // extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: Center(
              child: Text(
                'Hello!',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'How can we help you today?',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          _uploadWidget(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Upload Video',
                style: Theme.of(context).textTheme.headline6,
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
                  onTap: () {},
                  title: 'Drug Delivery',
                ),
                _featureButton(
                  child: Assets.images.iconNote.svg(height: 30), 
                  onTap: () {},
                  title: 'Side Effects',
                ),
                _featureButton(
                  child: Assets.images.iconMobileInfo.svg(height: 30), 
                  onTap: () {},
                  title: 'TB Info',
                ),
                _featureButton(
                  child: Assets.images.iconSupport.svg(height: 30), 
                  onTap: () {
                    Navigator.of(context).pushNamed("/scheduler");
                  },
                  title: 'Tele Consultation',
                ),
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}