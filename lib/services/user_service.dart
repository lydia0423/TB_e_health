import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/services/auth_service.dart';
import 'package:tb_e_health/services/video_service.dart';

class UserService {
  bool userLoggedIn(String uid) {
    return true;
  }

  Future<String> getUserEmailByUserId(String userId) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("User")
          .where("UserId", isEqualTo: userId)
          .limit(1)
          .get();

      dynamic json = userSnapshot.docs.first.data();
      final ActiveUser activeUser = ActiveUser.fromJson(json);
      String email = activeUser.email;
      print('getUserEmailByUserId: userId = ' + userId + ' , email = ' + email);
      return email;
    } catch (e) {
      print(e);
      return '';
    }
  }

  String getUserIdByUserEmail() {
    return '';
  }

  // check user uploaded video
  Future<bool> videoUploaded() async {
    AuthService _auth = AuthService();
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
