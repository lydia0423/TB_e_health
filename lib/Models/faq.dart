import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ {
  //^ Attributes
  String title, videoUrl;

  //^ Constructor
  FAQ(this.title, this.videoUrl);

  //? Converts the VideoUploaded into a map of key/value pairs

  Map<String, String> toJson() => _faqToJson(this);

  FAQ.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['FaqTitle'],
        videoUrl = snapshot['FaqVideo'];
}

//? Converts map of values from Firestore into VideoUploaded object.
FAQ faqFromJson(Map<dynamic, dynamic> json) {
  return FAQ(
    json["FaqTitle"] as String,
    json["FaqUrl"] as String,
  );
}

//? Converts the VideoUploaded class into key/value pairs
Map<String, String> _faqToJson(FAQ instance) => <String, String>{
      "FaqTitle": instance.title,
      "FaqVideo": instance.videoUrl,
    };

//? Retrieves all Book records
Stream<List<FAQ>> getAllFaqs() async* {
  List<FAQ> faq = [];
  await FirebaseFirestore.instance
      .collection("FAQ")
      .get()
      .then((value) =>
          value.docs.forEach((doc) => faq.add(faqFromJson(doc.data()))))
      .catchError((onError) => print(onError));
  yield faq;
}
