import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActiveUser {
  //^ Attributes
  String avatar, email, name, age, gender, healthInfo, address, userId, therapyEndDate, therapyStartDate;
  bool notificationPreference;

  //^ Constructor
  ActiveUser(this.avatar, this.email, this.name, this.age, this.gender,
      this.healthInfo, this.notificationPreference, this.address, this.userId, {
        this.therapyEndDate = "2021-08-20",
        this.therapyStartDate = "2021-09-30"});

  //? Factory - creates the ActiveUser instance from the JSON (database storage type) passed
  //? When Factory is used, implementing a constructor doesn't always create a new instance of its class
  factory ActiveUser.fromJson(Map<dynamic, dynamic> json) =>
      _activeUserFromJson(json);

  //? Converts the ActiveUser into a map of key/value pairs
  //Map<String, String> toJson() => _activeUserToJson(this);
}

//? Converts map of values from Firestore into ActiveUser class.
//! This method is invoked by ActiveUser.fromJson. Don't call this method.
ActiveUser _activeUserFromJson(Map<dynamic, dynamic> json) {
  return ActiveUser(
    (json["UserAvatar"] as String?)?? '',
    (json["UserEmail"] as String?)?? '',
    (json["UserName"] as String?)?? '',
    (json["UserAge"] as String?)?? '',
    (json["UserGender"] as String?)?? '',
    (json["UserHealthInfo"] as String?)?? '',
    (json["UserNotificationPreference"] as bool?)?? true,
    (json["UserAddress"] as String?)?? '',
    (json["UserId"] as String?)?? '',
    therapyEndDate: (json["TherapyEndDate"] as String?)?? '',
    therapyStartDate: (json["TherapyStartDate"] as String?)?? '',
  );
}

//? Converts the ActiveUser class into key/value pairs
Map<String, dynamic> _activeUserToJson(ActiveUser instance) =>
    <String, dynamic>{
      "UserAvatar": instance.avatar,
      "UserEmail": instance.email,
      "UserName": instance.name,
      "UserAge": instance.age,
      "UserGender": instance.gender,
      "UserHealthInfo": instance.healthInfo,
      "UserNotificationPreference": instance.notificationPreference,
      "UserAddress": instance.address,
      "UserId": instance.userId,
      "TherapyEndDate": instance.therapyEndDate,
      "TherapyStartDate": instance.therapyStartDate,
    };

//? Retrieves list of all users
Future<List<ActiveUser>> getAllUsers() async {
  List<ActiveUser> allUser = [];
  await FirebaseFirestore.instance
      .collection("User")
      .get()
      .then((value) => value.docs.forEach((element) {
            allUser.add(ActiveUser.fromJson(element.data()));
          }))
      .catchError((onError) => print(onError));
  return allUser;
}

//? Retrieve data from Firestore - Use with FutureBuilder
Future<DocumentSnapshot> getActiveUser() async {
  CollectionReference userDb = FirebaseFirestore.instance.collection("User");
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final currentId = currentUser!.uid;
  final activeUserDetails = await userDb.doc(currentId).get();
  return activeUserDetails;
}

//? Retrieves data from Firestore and stores in an ActiveUser object
Future<ActiveUser> myActiveUser({String? docId}) async {
  String currentId;
  User? currentUser = FirebaseAuth.instance.currentUser;
  (docId == null) ? currentId = currentUser!.uid : currentId = docId;

  var activeUserDetails =
      await FirebaseFirestore.instance.collection("User").doc(currentId).get();

  final ActiveUser activeUser = ActiveUser.fromJson(activeUserDetails.data()!);
  return activeUser;
}
