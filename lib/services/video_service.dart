import 'package:cloud_firestore/cloud_firestore.dart';

class VideoService {
  Future<bool> foundTodayVideo(String uid) async {
    DateTime now = new DateTime.now();
    DateTime tomorrowDate = DateTime(now.year, now.month, now.day + 1);
    DateTime todayDate = new DateTime(now.year, now.month, now.day);
    final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        todayDate.millisecondsSinceEpoch);
    final endAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        tomorrowDate.millisecondsSinceEpoch);

    var video = await FirebaseFirestore.instance
        .collection("VideoUploaded")
        .where("UserId", isEqualTo: uid)
        .where('VideoDateTime', isGreaterThanOrEqualTo: startAtTimestamp)
        .where('VideoDateTime', isLessThanOrEqualTo: endAtTimestamp)
        .orderBy('VideoDateTime', descending: true)
        .get()
        ;

    print(
        'foundTodayVideo: between $todayDate until $tomorrowDate, $uid uploaded video = ${video.size}');

    print('the field value :'+video.toString());

    if (video.size > 0) {
      return true;
    } else {
      return false;
    }
  }
}
