import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/bills/bills.dart';

class BillsDatabase {
   final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String docId, Map<String, dynamic> data ) async {
    try {
      await db.collection("rooms").doc(docId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return ;
    }
  }

  // Function to read a document
  Future<Bills?> getDocument( String documentId) async {
    try {
      final ref = db.collection("rooms").doc(documentId).withConverter(
      fromFirestore: Bills.fromFirestore,
      toFirestore: (Bills rooms, _) => rooms.toFirestore(),
    );
final docSnap = await ref.get();
final rooms = docSnap.data(); // Convert to City object
if (rooms != null) {
 return rooms;
} else {
  return null;
}
    } catch (e) {
      (e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument( String documentId, Map<String, dynamic> newData) async {
    try {
      await db.collection("rooms").doc(documentId).update(newData);
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
}