// enum OrderStatus{Pending,Arriving,Received,Unknown}

// OrderStatus? visibilityFromString(String value){
//   return OrderStatus.values.firstWhere(
//     (e)=>e.toString().split('.')[1]
//         .toUpperCase()==value.toUpperCase(),
//     orElse: () => OrderStatus.Unknown,
//   );
// }

// main(List<String> args) {
//   print(visibilityFromString("Pending"));
//   print(visibilityFromString("PENDING"));
//   print(visibilityFromString("Received"));
// }