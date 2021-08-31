import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/services/video_service.dart';

class UserService {
  Future<String> getUserEmailByUserId(String userId) async {
    try {
      print('getUserEmailByUserId: currentUser = $userId');
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("User")
          .where("UserId", isEqualTo: userId)
          .limit(1)
          .get();
      dynamic result = await FirebaseFirestore.instance
          .collection("User").get();
      dynamic json = userSnapshot.docs.first.data();
      final ActiveUser activeUser = ActiveUser.fromJson(json);
      String email = activeUser.email;
      print('getUserEmailByUserId: userId = ' + userId + ' , email = ' + email);
      return email;
    } catch (e) {
      print('getUserEmailByUserId: $e');
      return '';
    }
  }

  String getUserIdByUserEmail() {
    return '';
  }

  Future<ActiveUser> getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null || currentUser?.uid != null) {
      var activeUserDetails = await FirebaseFirestore.instance
          .collection("User")
          .doc(currentUser!.uid)
          .get();

      final ActiveUser activeUser =
      ActiveUser.fromJson(activeUserDetails.data()!);
      return activeUser;
    }
    return ActiveUser(
        '',
        '',
        '',
        '',
        '',
        '',
        false,
        '',
        '');
  }

  // check user uploaded video
  Future<bool> videoUploaded() async {
    VideoService _video = VideoService();

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null || currentUser?.uid != null) {
      var activeUserDetails = await FirebaseFirestore.instance
          .collection("User")
          .doc(currentUser!.uid)
          .get();

      final ActiveUser activeUser =
      ActiveUser.fromJson(activeUserDetails.data()!);

      print('videoUploaded: checking ' +
          activeUser.userId +
          ' today video status');
      // check if the video uploaded.
      bool foundVideo = await _video.foundTodayVideo(activeUser.userId);

      return foundVideo;
    }
    print('videoUploaded: user not loggedIn, cant check, thus no notification');
    return true;
  }
}
