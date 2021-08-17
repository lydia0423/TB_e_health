import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tb_e_health/Api/firebase_api.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/Custom%20Widgets/video_widget.dart';
import 'package:tb_e_health/Models/user.dart';
import 'package:tb_e_health/Models/video_uploaded.dart';
import 'package:tb_e_health/Screens/home_screen.dart';

// ignore: must_be_immutable
class UploadVideo extends StatefulWidget {
  final ValueNotifier<String> userId = ValueNotifier("");

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  File? fileMedia;
  UploadTask? task;
  String date = DateTime.now().toString();
  String? url;

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
              onPressed: () => Get.to(() => HomeScreen())),
        ),
      ),
      body: Column(
        children: [
          (fileMedia == null)
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 34.0, right: 30.0),
                  child: Container(
                    height: 480,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 34.0, right: 30.0),
                  child: Container(
                    height: 480,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: VideoWidget(fileMedia!),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 120.0),
                child: InkWell(
                    onTap: () => capture(MediaSource.video),
                    child: Icon(
                      Icons.fiber_manual_record,
                      color: Colors.red,
                      size: 150.0,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 30.0),
                child: InkWell(
                    onTap: () {
                      uploadFile();
                      customAlertDialog(context,
                          title: 'Reminder',
                          content: 'Upload video successfully');
                      // TODO: Get the userID
                      // if (await validUser(widget.userId.value)) {
                      //   uploadFile();
                      //   customAlertDialog(context,
                      //       title: 'Reminder',
                      //       content: 'Upload video successfully');
                      // }
                      // } else {
                      //   //~ UserId is invalid
                      //   customAlertDialog(context,
                      //       title: "Invalid User",
                      //       content: "No user with this ID has been found!");
                      // }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                      size: 40.0,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future capture(MediaSource source) async {
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
    final file = File(media!.path);

    return file;
  }

  Future uploadFile() async {
    if (fileMedia == null) return;

    final fileName = basename(fileMedia!.path);
    final destination = 'video/$fileName';

    task = FirebaseApi.uploadFile(destination, fileMedia!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() => {});
    url = await snapshot.ref.getDownloadURL();

    uploadVideo(uploadMyVideo(widget.userId));

    setState(() {
      fileMedia = null;
    });
  }

  VideoUploaded uploadMyVideo(ValueNotifier userId) {
    String videoPath = fileMedia.toString();
    String uid = userId.value;
    videoPath = url!;

    VideoUploaded myVideo = VideoUploaded(uid, date, videoPath);
    return myVideo;
  }
}
