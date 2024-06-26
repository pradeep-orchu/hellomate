import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/bills/bills.dart';

class BillsDatabase {
   final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String docId, Map<String, dynamic> data, String billsId) async {
    try {
      await db.collection("rooms").doc(docId).collection('bills').doc(billsId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return ;
    }
  }

  // Function to read a document
  Future<Bills?> getDocument( String documentId) async {
    try {
      final ref = db.collection("rooms").doc(documentId).collection('bills').doc().withConverter(
      fromFirestore: Bills.fromFirestore,
      toFirestore: (Bills bills, _) => bills.toFirestore(),
    );
final docSnap = await ref.get();
final bills = docSnap.data(); // Convert to City object
if (bills != null) {
 return bills;
} else {
  return null;
}
    } catch (e) {
      (e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument( String roomId, Map<String, dynamic> newData,String billsId) async {
    try {
      await db.collection("rooms").doc(roomId).collection('bills').doc(billsId).update(newData);
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

  Stream<List<Bills?>?> getNotes(String roomId) {
     return db.collection('rooms').doc(roomId).collection('bills').orderBy('billsId').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Bills.fromFirestore(doc, SnapshotOptions())).toList());
  }
}