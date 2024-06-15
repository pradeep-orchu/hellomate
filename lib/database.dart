import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String collectionName, Map<String, dynamic> data, String docId) async {
    try {
      await _db.collection(collectionName).doc(docId).set(data);
    } on FirebaseException catch (e) {
      return;
    }
  }

  // Function to read a document
  Future<Object?> getDocument(String collectionName, String documentId) async {
    try {
      DocumentSnapshot snapshot = await _db.collection(collectionName).doc(documentId).get();
      return snapshot.data();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument(String collectionName, String documentId, Map<String, dynamic> newData) async {
    try {
      await _db.collection(collectionName).doc(documentId).update(newData);
    } catch (e) {
      print(e);
    }
  }

  // Function to delete a document
  Future<void> deleteDocument(String collectionName, String documentId) async {
    try {
      await _db.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }

  // Function to get a list of documents in a collection
  Future<List<Object?>?> getCollection(String collectionName) async {
    try {
      QuerySnapshot snapshot = await _db.collection(collectionName).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
