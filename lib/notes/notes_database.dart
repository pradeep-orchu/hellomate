import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellomate/notes/notes.dart';

class NotesDatabase {
   final FirebaseFirestore db = FirebaseFirestore.instance;

  // Function to create a new document
   Future<void> createDocument(String docId, Map<String, dynamic> data, String noteId) async {
    try {
      await db.collection("rooms").doc(docId).collection('notes').doc(noteId).set(data);
    } on FirebaseException catch (e) {
      (e);
      return ;
    }
  }

  // Function to read a document
  Future<Notes?> getDocument( String documentId) async {
    try {
      final ref = db.collection("rooms").doc(documentId).collection('notes').doc().withConverter(
      fromFirestore: Notes.fromFirestore,
      toFirestore: (Notes notes, _) => notes.toFirestore(),
    );
final docSnap = await ref.get();
final notes = docSnap.data(); // Convert to City object
if (notes != null) {
 return notes;
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

  Stream<List<Notes?>?> getNotes(String roomId) {
     return db.collection('rooms').doc(roomId).collection('notes').orderBy('noteId').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Notes.fromFirestore(doc, SnapshotOptions())).toList());
  }
}