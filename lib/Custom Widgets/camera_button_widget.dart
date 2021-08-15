import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'list_tile_widget.dart';

class CameraButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: 'From Camera',
        icon: Icons.camera_alt,
        onClicked: () => pickCameraMedia(context),
      );

  Future pickCameraMedia(BuildContext context) async {
    final getMedia = ImagePicker().pickVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);

    Navigator.of(context).pop(file);
  }
}
