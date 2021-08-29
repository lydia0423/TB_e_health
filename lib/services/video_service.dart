import 'package:cloud_firestore/cloud_firestore.dart';

class VideoService {
  Future<bool> foundTodayVideo(String uid) async {
    var video = await FirebaseFirestore.instance
        .collection("VideoUploaded")
        .where("UserId", isEqualTo: uid)
        .where("VideoTimestamp", isGreaterThanOrEqualTo: new DateTime.now())
        .get();

    print('foundTodayVideo: found video = ${video.size}');

    if (video.size > 0) {
      return true;
    } else {
      return false;
    }
  }
}
