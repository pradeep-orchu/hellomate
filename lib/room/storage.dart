import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
 Future<String?> uploadImage(String fileName, File imageFile) async {
    try {
    
      
      // Upload the image to Firebase Storage
      TaskSnapshot snapshot = await storage.ref().child(fileName).putFile(imageFile);

      // Get the download URL of the uploaded image
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      ( e);
      return e.toString();
    }
  }
}