import 'package:cloud_firestore/cloud_firestore.dart';

class Rooms {
  final int? roomId;
  final String? description;
  final String? image;
  final String? rules;
  final String? address;
  final String? state;
  final String? country;
  final String? city;
  final int? pincode;
  final int? rent;
  final List<String>? nearby;
  final bool? isFemale;
  final int? food;
  final List<String>? mates;

  Rooms({
    this.nearby,
    this.isFemale,
    this.description, 
    this.rules, 
    this.image,
    this.address,
    this.rent, 
    this.food,
    this.roomId,
    this.state,
    this.country,
    this.city,
    this.pincode,
    this.mates,
  });

  factory Rooms.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Rooms(
      roomId: data?['roomId'],
      isFemale: data?['isFemale'],
      state: data?['state'],
      country: data?['country'],
      city: data?['city'],
      pincode: data?['pincode'],
      rent: data?['rent'],
      rules: data?['rules'],
      image: data?['image'],
      address: data?['address'],
      food: data?['food'],
      description: data?['description'],
       nearby:
          data?['nearby'] is Iterable ? List.from(data?['nearby']) : null,
      mates:
          data?['mates'] is Iterable ? List.from(data?['mates']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (roomId != null) "roomId": roomId,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (city != null) "city": city,
      if (pincode != null) "pincode": pincode,
      if (mates != null) "mates": mates,
      if (image != null) "image": image,
      if (rent != null) "rent": rent,
      if (food != null) "food": food,
      if (address != null) "address": address,
      if (description != null) "description": description,
      if (rules != null) "rules": rules,
      if (isFemale != null) "isFemale": isFemale,
      if (nearby != null) "nearby": nearby,
    };
  }
}