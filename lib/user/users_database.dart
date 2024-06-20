import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/user/users.dart';

class UsersDatabase {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> addDocument( Map<String, dynamic> data, String docId) async {
    try {
      await db.collection("users").doc(docId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return;
    }
  }

  // Function to read a document
  Future<Users?> getDocument(String documentId) async {
    try {
     final ref = db.collection("users").doc(documentId).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users users, _) => users.toFirestore(),
    );
final docSnap = await ref.get();
final users = docSnap.data(); // Convert to City object
if (users != null) {
 return users;
} else {
  return null;
}
    } catch (e) {
      (e);
      return null;
    }
  }

  // Function to update a document
  Future<void> updateDocument(String documentId, Map<String, dynamic> newData) async {
    try {
      await db.collection('users').doc(documentId).update(newData);
    } catch (e) {
      (e);
    }
  }

  // Function to delete a document
  Future<void> deleteDocument(String documentId) async {
    try {
      await db.collection('users').doc(documentId).delete();
    } catch (e) {
      (e);
    }
  }

  // Function to get a list of documents in a collection
  Future<List<Object?>?> getCollection() async {
    try {
      QuerySnapshot snapshot = await db.collection('users').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      (e);
      return null;
    }
  }
}
