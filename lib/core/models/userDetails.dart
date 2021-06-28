import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String uid;
  String name;
  String email;
  String bloodGroup;
  GeoPoint location;
  UserDetails(
      {this.uid, this.name, this.email, this.bloodGroup, this.location});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bloodGroup': bloodGroup,
      'location': location
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      bloodGroup: map['bloodGroup'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));
}
