import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  final int? roomId;
  final String? context;
  final String? noteId;
  final String? user;
  final String? time;
  final List<String>? likes;

  Notes({
    this.context, 
    this.user, 
    this.noteId,
    this.time,
    this.roomId,
    this.likes,
  });

  factory Notes.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Notes(
      roomId: data?['roomId'],
      user: data?['user'],
      noteId: data?['noteId'],
      time: data?['time'],
      context: data?['context'],
      likes:
          data?['likes'] is Iterable ? List.from(data?['likes']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (roomId != null) "roomId": roomId,
      if (likes != null) "likes": likes,
      if (noteId != null) "noteId": noteId,
      if (time != null) "time": time,
      if (context != null) "context": context,
      if (user != null) "user": user,
    };
  }
}