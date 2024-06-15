import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? name;
  final String? city;
  final String? country;
  final bool? inRoom;
  final String? state;
  final String? age;
  final String? gender;
  final String? status;
  final String? pincode;
  final String? about;

  Users({
    this.state,
    this.age, 
    this.gender, 
    this.status,
    this.name,
    this.city,
    this.country,
    this.inRoom,
    this.pincode,
    this.about,
  });

  factory Users.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Users(
      name: data?['name'],
      gender: data?['gender'],
      state: data?['state'],
      age: data?['age'],
      status: data?['status'],
      city: data?['city'],
      country: data?['country'],
      inRoom: data?['inRoom'],
      pincode: data?['pincode'],
      about: data?['about'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (status != null) "status": status,
      if (state != null) "state": state,
      if (gender != null) "gender": gender,
      if (city != null) "city": city,
      if (country != null) "country": country,
      if (inRoom != null) "inRoom": inRoom,
      if (pincode != null) "pincode": pincode,
      if (about != null) "about": about,
    };
  }
}