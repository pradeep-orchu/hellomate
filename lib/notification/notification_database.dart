import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/notification/notification.dart';

class NotificationDatabase {
   final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String docId, Map<String, dynamic> data, String notificationId) async {
    try {
      await db.collection("rooms").doc(docId).collection('notifications').doc(notificationId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return ;
    }
  }

  // Function to read a document
  Future<Notifications?> getDocument( String documentId) async {
    try {
      final ref = db.collection("rooms").doc(documentId).collection('notifications').doc().withConverter(
      fromFirestore: Notifications.fromFirestore,
      toFirestore: (Notifications notifications, _) => notifications.toFirestore(),
    );
final docSnap = await ref.get();
final notifications = docSnap.data(); // Convert to City object
if (notifications != null) {
 return notifications;
} else {
  return null;
}
    } catch (e) {
      (e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument( String roomId, Map<String, dynamic> newData,String notificationId) async {
    try {
      await db.collection("rooms").doc(roomId).collection('notifications').doc(notificationId).update(newData);
    } catch (e) {
      (e);
    }
  }

  // Function to delete a document
  Future<void> deleteDocument( String documentId) async {
    try {
      await db.collection("rooms").doc(documentId).delete();
    } catch (e) {
      (e);
    }
  }

  // Function to get a list of documents in a collection
  Future<List<Object?>?> getCollection() async {
    try {
      QuerySnapshot snapshot = await db.collection("rooms").get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      (e);
      return null;
    }
  }

  Stream<List<Notifications?>?> getNotes(String roomId) {
     return db.collection('rooms').doc(roomId).collection('notifications').orderBy('notificationId').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Notifications.fromFirestore(doc, SnapshotOptions())).toList());
  }
}