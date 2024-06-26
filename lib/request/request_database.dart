import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/request/request.dart';

class RequestDatabase {
   final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String docId, Map<String, dynamic> data, String requestId) async {
    try {
      await db.collection("rooms").doc(docId).collection('requests').doc(requestId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return ;
    }
  }

  // Function to read a document
  Future<Requests?> getDocument( String documentId) async {
    try {
      final ref = db.collection("rooms").doc(documentId).collection('requests').doc().withConverter(
      fromFirestore: Requests.fromFirestore,
      toFirestore: (Requests requests, _) => requests.toFirestore(),
    );
final docSnap = await ref.get();
final requests = docSnap.data(); // Convert to City object
if (requests != null) {
 return requests;
} else {
  return null;
}
    } catch (e) {
      (e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument( String roomId, Map<String, dynamic> newData,String requestId) async {
    try {
      await db.collection("rooms").doc(roomId).collection('requests').doc(requestId).update(newData);
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

  Stream<List<Requests?>?> getRequest(String roomId) {
     return db.collection('rooms').doc(roomId).collection('requests')
     //.orderBy('requestId', descending: true)
     .snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Requests.fromFirestore(doc, SnapshotOptions())).toList());
  }
}