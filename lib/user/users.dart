import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? userId;
  final String? name;
  final String? city;
  final String? country;
  final String? inRoom;
  final String? state;
  final int? age;
  final String? gander;
  final String? status;
  final int? pincode;
  final String? about;

  Users({
    this.userId,
    this.state,
    this.age, 
    this.gander, 
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
      userId: data?['userId'],
      name: data?['name'],
      gander: data?['gander'],
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
      if (userId != null) "userId": userId,
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (status != null) "status": status,
      if (state != null) "state": state,
      if (gander != null) "gander": gander,
      if (city != null) "city": city,
      if (country != null) "country": country,
      if (inRoom != null) "inRoom": inRoom,
      if (pincode != null) "pincode": pincode,
      if (about != null) "about": about,
    };
  }
}