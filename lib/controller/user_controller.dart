import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/services/firestore_service.dart';
import '../core/services/storage_service.dart';
import '../data/models/user_model.dart';

class UserController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  final FirestoreService _firestoreService =
      FirestoreService();

  final Uuid _uuid = const Uuid();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> addUser({
    required String name,
    required String phone,
    required int age,
    required File imageFile,
  }) async {
    try {
      _isLoading = true;

      notifyListeners();

      final String imageUrl =
          await _storageService.uploadUserImage(
        imageFile,
      );

      final String userId = _uuid.v4();

      final UserModel user = UserModel(
        id: userId,
        name: name,
        phone: phone,
        age: age,
        imageUrl: imageUrl,
        createdAt: Timestamp.now(),
      );

      await _firestoreService.addUser(user);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}