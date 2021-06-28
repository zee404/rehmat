import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BloodRequest {
  String uid;
  String bloodGroup;
  String quantity;
  DateTime dueDate;
  String phone;
  GeoPoint location;
  String address;
  BloodRequest({
    this.uid,
    this.bloodGroup,
    this.quantity,
    this.dueDate,
    this.phone,
    this.location,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'bloodGroup': bloodGroup,
      'quantity': quantity,
      'dueDate': dueDate,
      'phone': phone,
      'location': location,
      'address': address,
    };
  }

  factory BloodRequest.fromMap(Map<String, dynamic> map) {
    return BloodRequest(
      uid: map['uid'],
      bloodGroup: map['bloodGroup'],
      quantity: map['quantity'],
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      phone: map['phone'],
      location: map['location'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodRequest.fromJson(String source) =>
      BloodRequest.fromMap(json.decode(source));
}
