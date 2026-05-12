import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../core/services/firestore_service.dart';
import '../core/services/storage_service.dart';
import '../data/models/user_model.dart';

class UserController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  final FirestoreService _firestoreService =
      FirestoreService();

  final ImagePicker _imagePicker = ImagePicker();

  final Uuid _uuid = const Uuid();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController ageController =
      TextEditingController();

  final TextEditingController searchController =
      TextEditingController();

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  bool _isLoading = false;

  File? _selectedImage;

  List<UserModel> _users = [];

  List<UserModel> _filteredUsers = [];

  bool get isLoading => _isLoading;

  File? get selectedImage => _selectedImage;

  List<UserModel> get users => _users;

  List<UserModel> get filteredUsers =>
      _filteredUsers;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_selectedImage == null) {
      throw Exception('Please select an image');
    }

    try {
      _isLoading = true;

      notifyListeners();

      final String imageUrl =
          await _storageService.uploadUserImage(
        _selectedImage!,
      );

      final String userId = _uuid.v4();

      final UserModel user = UserModel(
        id: userId,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        age: int.parse(ageController.text.trim()),
        imageUrl: imageUrl,
        createdAt: Timestamp.now(),
      );

      await _firestoreService.addUser(user);

      await fetchUsers();

      clearFields();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> fetchUsers() async {
    try {
      _isLoading = true;

      notifyListeners();

      _users =
          await _firestoreService.fetchUsers();

      _filteredUsers = _users;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void searchUsers(String query) {
    if (query.trim().isEmpty) {
      _filteredUsers = _users;
    } else {
      _filteredUsers = _users.where((user) {
        final String name =
            user.name.toLowerCase();

        final String phone =
            user.phone.toLowerCase();

        final String searchQuery =
            query.toLowerCase();

        return name.contains(searchQuery) ||
            phone.contains(searchQuery);
      }).toList();
    }

    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    ageController.clear();

    _selectedImage = null;

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    searchController.dispose();

    super.dispose();
  }
}