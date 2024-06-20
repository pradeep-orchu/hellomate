import 'package:cloud_firestore/cloud_firestore.dart';

class Bills {
  final int? roomId;
  final String? context;
  final String? billId;
  final String? user;
  final String? time;
  final List<String>? mates;

  Bills({
    this.context, 
    this.user, 
    this.billId,
    this.time,
    this.roomId,
    this.mates,
  });

  factory Bills.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Bills(
      roomId: data?['roomId'],
      user: data?['user'],
      billId: data?['iamge'],
      time: data?['time'],
      context: data?['context'],
      mates:
          data?['mates'] is Iterable ? List.from(data?['mates']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (roomId != null) "roomId": roomId,
      if (mates != null) "mates": mates,
      if (billId != null) "billId": billId,
      if (time != null) "time": time,
      if (context != null) "context": context,
      if (user != null) "user": user,
    };
  }
}