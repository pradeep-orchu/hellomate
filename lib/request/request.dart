import 'package:cloud_firestore/cloud_firestore.dart';

class Requests {
  final int? roomId;
  final bool? agree;
  final List<String>? agreed;
  final int? type;
  final String? context;
  final String? requestId;
  final String? user;
  final String? time;
  final List<String>? mates;
  final List<String>? isSeen;

  Requests({
    this.agreed,
    this.agree,
    this.type,
    this.context, 
    this.user, 
    this.requestId,
    this.time,
    this.roomId,
    this.mates,
    this.isSeen
  });

  factory Requests.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Requests(
      agreed: data?['agreed'] is Iterable ? List.from(data?['agreed']): null,
      roomId: data?['roomId'],
      user: data?['user'],
      type: data?['type'],
      requestId: data?['requestId'],
      time: data?['time'],
      context: data?['context'],
      mates:
          data?['mates'] is Iterable ? List.from(data?['mates']) : null,
      isSeen:
          data?['isSeen'] is Iterable ? List.from(data?['isSeen']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (agreed != null) "isSeen":isSeen,
      if (agreed != null ) "agreed": agreed,
      if (roomId != null) "roomId": roomId,
      if (mates != null) "mates": mates,
      if (type != null) "type": type,
      if (requestId != null) "requestId": requestId,
      if (time != null) "time": time,
      if (context != null) "context": context,
      if (user != null) "user": user,
    };
  }
}