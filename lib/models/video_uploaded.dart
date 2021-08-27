import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaSource { video }

class VideoUploaded {
  //^ Attributes
  String userId, videoUrl, timestamp;
  String? videoId;

  //^ Constructor
  VideoUploaded(this.userId, this.timestamp, this.videoUrl, [this.videoId]);

  //? Converts the VideoUploaded into a map of key/value pairs
  Map<String, String> toJson() => _videoUploadedToJson(this);

  VideoUploaded.fromSnapshot(DocumentSnapshot snapshot)
      : userId = snapshot['UserId'],
        videoId = snapshot.id,
        videoUrl = snapshot['VideoUrl'],
        timestamp = snapshot['VideoTimestamp'];
}

//? Converts map of values from Firestore into VideoUploaded object.
VideoUploaded videoUploadedFromJson(Map<dynamic, dynamic> json) {
  return VideoUploaded(
    json["UserId"] as String,
    json["VideoId"] as String,
    json["VideoUrl"] as String,
    json["videoTimestamp"] as String,
  );
}

//? Converts the VideoUploaded class into key/value pairs
Map<String, String> _videoUploadedToJson(VideoUploaded instance) =>
    <String, String>{
      "UserId": instance.userId,
      "VideoUrl": instance.videoUrl,
      "VideoTimestamp": instance.timestamp,
    };

//? Upload video
Future<String?> uploadVideo(VideoUploaded video) async {
  String? docId;
  await FirebaseFirestore.instance
      .collection("VideoUploaded")
      .add(_videoUploadedToJson(video))
      .then(
        (value) => docId = value.id,
      )
      .catchError((onError) => print("An error was encountered: $onError"));

  return docId;
}

Future<List<VideoUploaded>> findVideoUploadedOfUser(String userId) async {
  List<VideoUploaded> result = [];
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("VideoUploaded")
        .where("UserId", isEqualTo: userId)
        .get();
    for (var doc in snapshot.docs) {
      var submission = videoUploadedFromJson(doc.data() as Map<String, dynamic>);
      result.add(submission);
    }
    return result;
  } catch (e) {
    print(e);
    return result;
  }
}