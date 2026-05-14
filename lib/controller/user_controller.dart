import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/firestore_service.dart';
import '../core/services/storage_service.dart';
import '../data/models/user_model.dart';

enum SortType { ageAscending, ageDescending }

class UserController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  final FirestoreService _firestoreService = FirestoreService();

  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _isPaginationLoading = false;

  bool _hasMore = true;

  File? _selectedImage;

  DocumentSnapshot? _lastDocument;

  List<UserModel> _users = [];

  List<UserModel> _filteredUsers = [];

  SortType _sortType = SortType.ageAscending;
  String? _lastErrorMessage;

  String? _currentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  bool get isLoading => _isLoading;

  bool get isPaginationLoading => _isPaginationLoading;

  bool get hasMore => _hasMore;

  File? get selectedImage => _selectedImage;

  List<UserModel> get users => _users;

  List<UserModel> get filteredUsers => _filteredUsers;

  SortType get sortType => _sortType;
  String? get lastErrorMessage => _lastErrorMessage;

  String? consumeError() {
    final String? message = _lastErrorMessage;
    _lastErrorMessage = null;
    return message;
  }

  void _setError(Object error) {
    if (error is FirebaseException) {
      if (error.code == 'permission-denied') {
        _lastErrorMessage =
            'Permission denied by Firebase rules. Please check Firestore rules.';
        return;
      }
      if (error.code == 'failed-precondition') {
        _lastErrorMessage =
            'Firestore index is missing. Create the suggested index in Firebase console.';
        return;
      }
      _lastErrorMessage = error.message ?? 'Firebase error: ${error.code}';
      return;
    }

    _lastErrorMessage = error.toString();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
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

  Future<bool> addUser() async {
    try {
      _lastErrorMessage = null;

      if (!formKey.currentState!.validate()) {
        return false;
      }

      final String? currentUserId = _currentUserId();
      if (currentUserId == null || currentUserId.isEmpty) {
        _lastErrorMessage = 'You are not signed in. Please login again.';
        return false;
      }

      _isLoading = true;

      notifyListeners();

      String imageUrl = '';

      if (_selectedImage != null) {
        imageUrl = await _storageService.uploadUserImage(_selectedImage!);
      }

      final user = UserModel(
        id: '',

        ownerId: currentUserId,

        name: nameController.text.trim(),

        phone: phoneController.text.trim(),

        age: int.parse(ageController.text.trim()),

        imageUrl: imageUrl,

        createdAt: Timestamp.now(),
      );

      await _firestoreService.addUser(user);

      resetPagination();

      await fetchPaginatedUsers();

      nameController.clear();

      phoneController.clear();

      ageController.clear();

      _selectedImage = null;

      notifyListeners();

      return true;
    } catch (e) {
      _setError(e);
      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> fetchUsers() async {
    try {
      _lastErrorMessage = null;
      _isLoading = true;

      notifyListeners();

      final String? currentUserId = _currentUserId();
      if (currentUserId == null || currentUserId.isEmpty) {
        _lastErrorMessage = 'You are not signed in. Please login again.';
        _users = [];
        _filteredUsers = [];
        return;
      }

      _users = await _firestoreService.fetchUsers(currentUserId);

      _filteredUsers = List.from(_users);

      sortUsers(_sortType);
    } catch (e) {
      _setError(e);
      _users = [];
      _filteredUsers = [];
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> fetchPaginatedUsers() async {
    if (_isPaginationLoading || !_hasMore) {
      return;
    }

    _lastErrorMessage = null;

    final String? currentUserId = _currentUserId();
    if (currentUserId == null || currentUserId.isEmpty) {
      _lastErrorMessage = 'You are not signed in. Please login again.';
      _users = [];
      _filteredUsers = [];
      _hasMore = false;
      notifyListeners();
      return;
    }

    try {
      _isPaginationLoading = true;

      notifyListeners();

      final QuerySnapshot querySnapshot = await _firestoreService
          .fetchPaginatedUsers(
            ownerId: currentUserId,

            lastDocument: _lastDocument,
          );

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
      }

      final List<UserModel> newUsers =
          querySnapshot.docs.map((doc) {
            return UserModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

      if (newUsers.length < 10) {
        _hasMore = false;
      }

      _users.addAll(newUsers);

      _filteredUsers = List.from(_users);

      sortUsers(_sortType);
    } catch (e) {
      _setError(e);
      _hasMore = false;
    } finally {
      _isPaginationLoading = false;

      notifyListeners();
    }
  }

  void searchUsers(String query) {
    if (query.trim().isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers =
          _users.where((user) {
            final String name = user.name.toLowerCase();

            final String phone = user.phone.toLowerCase();

            final String searchQuery = query.toLowerCase();

            return name.contains(searchQuery) || phone.contains(searchQuery);
          }).toList();
    }

    sortUsers(_sortType);
  }

  void sortUsers(SortType type) {
    _sortType = type;

    if (type == SortType.ageAscending) {
      _filteredUsers.sort((a, b) => a.age.compareTo(b.age));
    } else {
      _filteredUsers.sort((a, b) => b.age.compareTo(a.age));
    }

    notifyListeners();
  }

  void resetPagination() {
    _users.clear();

    _filteredUsers.clear();

    _lastDocument = null;

    _hasMore = true;

    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    ageController.clear();

    _selectedImage = null;

    notifyListeners();
  }

  void clearSessionState() {
    _users.clear();
    _filteredUsers.clear();
    _lastDocument = null;
    _hasMore = true;
    _isLoading = false;
    _isPaginationLoading = false;
    _lastErrorMessage = null;
    searchController.clear();
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
