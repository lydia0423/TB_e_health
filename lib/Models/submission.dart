import 'package:cloud_firestore/cloud_firestore.dart';

class Submission {
  String? userId;
  DateTime? videoTimestamp;
  String? videoUrl;

  Submission({this.userId, this.videoTimestamp, this.videoUrl});

  Submission.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    videoTimestamp = DateTime.parse(json['VideoTimestamp']);
    videoUrl = json['VideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['VideoTimestamp'] = this.videoTimestamp;
    data['VideoUrl'] = this.videoUrl;
    return data;
  }
}

Future<List<Submission>> findSubmissionOfUser(String userId) async {
  List<Submission> result = [];
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("VideoUploaded")
        .where("UserId", isEqualTo: userId)
        .get();
    print('\n\tConverting\n');
    for (var doc in snapshot.docs) {
      var submission = Submission.fromJson(doc.data() as Map<String, dynamic>);
      result.add(submission);
    }
    return result;
  } catch (e) {
    print(e);
    return result;
  }
}

// TODO: submission on video