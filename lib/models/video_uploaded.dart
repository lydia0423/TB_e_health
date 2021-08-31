import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaSource { video }

class VideoUploaded {
  //^ Attributes
  String userId;
  String videoUrl;
  DateTime dateTime;

  // String timestamp;
  // String videoId;

  //^ Constructor
  VideoUploaded(this.userId, this.videoUrl, this.dateTime);

  //? Converts the VideoUploaded into a map of key/value pairs
  Map<String, dynamic> toJson() => _videoUploadedToJson(this);

  VideoUploaded.fromSnapshot(DocumentSnapshot snapshot)
      : userId = snapshot['UserId'],
        // videoId = snapshot.id,
        videoUrl = snapshot['VideoUrl'],
        dateTime = snapshot['VideoDateTime']
  // timestamp = snapshot['VideoTimestamp']
  ;
}

//? Converts map of values from Firestore into VideoUploaded object.
VideoUploaded videoUploadedFromJson(Map<dynamic, dynamic> json) {
  return VideoUploaded(
    json["UserId"] as String,
    // json["VideoId"] as String,
    json["VideoUrl"] as String,
    json["VideoDateTime"].toDate() as DateTime,
    // json["videoTimestamp"] as String,
  );
}

//? Converts the VideoUploaded class into key/value pairs
Map<String, dynamic> _videoUploadedToJson(VideoUploaded instance) =>
    <String, dynamic>{
      "UserId": instance.userId,
      "VideoUrl": instance.videoUrl,
      "VideoDateTime": instance.dateTime,
      // "VideoTimestamp": instance.timestamp,
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
  print('findVideoUploadedOfUser: ' + userId);
  List<VideoUploaded> result = [];
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("VideoUploaded")
        .where("UserId", isEqualTo: userId)
        .get();
    print('findVideoUploadedOfUser: result.size ${snapshot.size}');
    for (var doc in snapshot.docs) {
      var v = videoUploadedFromJson(doc.data() as Map<String, dynamic>);
      print('findVideoUploadedOfUser: ' + v.userId);
      print('findVideoUploadedOfUser: ' + v.videoUrl);
      print('findVideoUploadedOfUser: ' + v.dateTime.toString());
      result.add(v);
    }
    return result;
  } catch (e) {
    print(e);
    return result;
  }
}
