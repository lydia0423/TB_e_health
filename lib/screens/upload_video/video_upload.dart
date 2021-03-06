import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tb_e_health/services/upload_video_service.dart';
import 'package:tb_e_health/custom_widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/custom_widgets/video_widget.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/video_uploaded.dart';
import 'package:tb_e_health/common/constants.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';

// ignore: must_be_immutable
class UploadVideo extends StatefulWidget {
  final ValueNotifier<String> userId = ValueNotifier("");

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  File? fileMedia;
  UploadTask? task;
  String? url;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("prepare to upload video...");
    return Scaffold(
      appBar: CommonAppBar(title: 'Capture Video'),
      body: Column(
        children: [
          (fileMedia == null)
              ? Expanded(
                  child: Center(
                    child: Container(
                      // height: height-0.0,
                      width: width - 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.grey),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    // height: height-0.0,
                    width: width - 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: VideoWidget(fileMedia!),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => capture(MediaSource.video),
                child: Icon(
                  Icons.fiber_manual_record,
                  color: Colors.red,
                  size: 80.0,
                ),
              ),
              InkWell(
                onTap: () => upload(context),
                child: Icon(
                  Icons.send,
                  color: Colors.black,
                  size: 60.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => capture(MediaSource.video),
                child: Text('Record',
                    style: TextStyle(fontSize: Constants.buttonFs)),
              ),
              InkWell(
                onTap: () => upload(context),
                child: Text('Upload',
                    style: TextStyle(fontSize: Constants.buttonFs)),
              ),
            ],
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Future capture(MediaSource source) async {
    print("recording...");
    setState(() {
      this.fileMedia = null;
    });
    final result = await pickCameraMedia();

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }

  Future pickCameraMedia() async {
    final getMedia = ImagePicker().pickVideo;

    final media = await getMedia(source: ImageSource.camera);
    if (media == null) {
      return;
    } else {
      final file = File(media.path);
      return file;
    }
  }

  Future uploadFile() async {
    if (fileMedia == null) return;

    final fileName = basename(fileMedia!.path);
    final destination = 'video/$fileName';

    task = FirebaseApi.uploadFile(destination, fileMedia!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() => {});
    url = await snapshot.ref.getDownloadURL();

    VideoUploaded? videoToUpload = await uploadMyVideo();
    if (videoToUpload != null) {
      uploadVideo(videoToUpload);
    }

    setState(() {
      fileMedia = null;
    });
  }

  Future<VideoUploaded?> uploadMyVideo() async {
    String videoPath = fileMedia.toString();
    ActiveUser currentUser = await myActiveUser();
    String userId = currentUser.userId;
    print(userId + " uploaded a video...");
    videoPath = url!;

    VideoUploaded myVideo = VideoUploaded(userId, videoPath, DateTime.now());
    return myVideo;
  }

  Future<void> upload(context) async {
    if (fileMedia != null) {
      uploadFile();
      customAlertDialog(context,
          title: 'Success', content: 'Video Uploaded successfully');
    } else {
      customAlertDialog(context,
          title: 'Warning', content: 'No video is recorded');
    }
  }
}
