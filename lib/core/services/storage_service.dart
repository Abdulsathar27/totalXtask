import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instance;

  final Uuid _uuid = const Uuid();

  Future<String> uploadUserImage(File imageFile) async {
    try {
      final String fileName = _uuid.v4();

      final Reference reference = _firebaseStorage
          .ref()
          .child('user_images')
          .child('$fileName.jpg');

      final UploadTask uploadTask =
          reference.putFile(imageFile);

      final TaskSnapshot taskSnapshot =
          await uploadTask;

      final String downloadUrl =
          await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}