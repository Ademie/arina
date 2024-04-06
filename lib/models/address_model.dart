// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddressModel {
//   String? description;
//   double? latitude;
//   double? longitude;

//   AddressModel({
//     this.description,
//     this.latitude,
//     this.longitude,
//   });

//   factory AddressModel.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data();
//     return AddressModel(
//         latitude: data?["latitude"],
//         longitude: data?["longitude"],
//         description: data?["description"]);
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       if (!latitude!.isNaN) "latitude": latitude,
//       if (!longitude!.isNaN) "longitude": longitude,
//       if (description!.isNotEmpty) "description": description
//     };
//   }
// }
