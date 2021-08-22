import 'package:cloud_firestore/cloud_firestore.dart';

// enum OrderStatus{Pending,Arriving,Received,Unknown}

// OrderStatus? visibilityFromString(String value){
//   return OrderStatus.values.firstWhere(
//     (e)=>e.toString().split('.')[1]
//         .toUpperCase()==value.toUpperCase(),
//     orElse: () => OrderStatus.Unknown,
//   );
// }

// enum
class OrderStatus {
  static const String Pending = "Pending";
  static const String Arriving = "Arriving";
  static const String Received = "Received";
}

class OrderType {
  static const String Delivery = "Delivery";
  static const String Pickup = "Pickup";
}

class DrugDeliveryRequest {
  String type;
  String approvedBy;
  String id;
  List<String> item;
  String status;
  String requestDate;
  String therapyEndDate;
  String therapyStartDate;
  String userAddress;
  String userId;
  String userName;

  DrugDeliveryRequest({
    this.type = OrderType.Delivery,
    this.approvedBy = "Dr.John",
    this.id = "UMO00001",
    this.item = const ["Rifampicin Tablets x15 Isoniazid Tablets x15"],
    this.status = OrderStatus.Pending,
    this.requestDate = "2021-08-14",
    this.therapyStartDate = "2021-08-20",
    this.therapyEndDate = "2021-08-31",
    this.userAddress = "",
    this.userId = "UM00001",
    this.userName = "Lydia",
  });

  factory DrugDeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DrugDeliveryRequest(
      type: json["orderType"]?? '',
      approvedBy: json["OrderApprovedBy"]?? '',
      id: json["OrderId"]?? '',
      item: ((json["OrderItem"]?? []) as List<dynamic>).map<String>((e) => e).toList(),
      status: json["OrderStatus"]?? '',
      requestDate: json["RequestDate"]?? '',
      therapyEndDate: json["OrderTherapyEndDate"]?? '',
      therapyStartDate: json["OrderTherapyStartDate"]?? '',
      userAddress: json["UserAddress"]?? '',
      userId: json["UserId"]?? '',
      userName: json["UserName"]?? '',
    );
  }
}

Future<List<DrugDeliveryRequest>> findDrugDeliveryRequestOfUser(String userId, {bool history = false}) async {
  List<DrugDeliveryRequest> result = [];
  try {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection("DrugDeliveryRequest")
        .where("UserId", isEqualTo: userId);
    if (history) {
      query = query.where("OrderStatus", isEqualTo: OrderStatus.Received);
    } else {
      query = query.where("OrderStatus", isNotEqualTo: OrderStatus.Received);
    }
    QuerySnapshot snapshot = await query.get();
    for (var doc in snapshot.docs) {
      print(doc.data());
      var submission = DrugDeliveryRequest.fromJson(doc.data() as Map<String, dynamic>);
      result.add(submission);
    }
    print(result.length);
    return result;
  } catch (e) {
    print(e);
    return result;
  }
}