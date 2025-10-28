import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      if (await file.exists()) {
        await storage.ref('documents/$fileName').putFile(file);
        // File uploaded successfully!
      } else {
        // File does not exist at the specified path
      }
    } catch (e) {
      // Error uploading file
      // If you want to print a more specific error message for Firebase exceptions:
      if (e is firebase_core.FirebaseException) {
        // Firebase Error Code
        // Firebase Error Message
      }
    }
  }

  uploadImage(File file) {}
}
