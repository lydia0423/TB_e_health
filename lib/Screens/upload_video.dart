import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/camera_button_widget.dart';
import 'package:tb_e_health/Custom%20Widgets/gallery_button_widget.dart';

class SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Source',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      )),
    );
  }
}
