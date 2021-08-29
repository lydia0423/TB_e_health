import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tb_e_health/Api/firebase_api.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/Custom%20Widgets/video_widget.dart';
import 'package:tb_e_health/Models/active_user.dart';
import 'package:tb_e_health/Models/video_uploaded.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';

// ignore: must_be_immutable
class UploadVideo extends StatefulWidget {
  final ValueNotifier<String> userId = ValueNotifier("");

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  File? fileMedia;
  UploadTask? task;
  DateTime datetime = DateTime.now();
  String? url;

  @override
  Widget build(BuildContext context) {
    print("prepare to upload video...");
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveChat();
        })),
        child: Icon(Icons.live_help_outlined),
        backgroundColor: Colors.black,
      ),
      body: ListView(
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
                    onTap: () async {
                      if (fileMedia != null) {
                        uploadFile();
                        customAlertDialog(context,
                            title: 'Reminder',
                            content: 'Upload video successfully');
                      } else {
                        customAlertDialog(context,
                            title: 'Warning', content: 'No video is recorded');
                      }
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

    VideoUploaded myVideo = VideoUploaded(userId, videoPath, datetime);
    return myVideo;
  }
}
