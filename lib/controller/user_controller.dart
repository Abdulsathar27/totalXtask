import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/firestore_service.dart';
import '../core/services/storage_service.dart';
import '../data/models/user_model.dart';

enum SortType {
  ageAscending,
  ageDescending,
}

class UserController extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  final FirestoreService _firestoreService =
      FirestoreService();

  final ImagePicker _imagePicker = ImagePicker();

  

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

  bool _isPaginationLoading = false;

  bool _hasMore = true;

  File? _selectedImage;

  DocumentSnapshot? _lastDocument;

  List<UserModel> _users = [];

  List<UserModel> _filteredUsers = [];

  SortType _sortType = SortType.ageAscending;

  bool get isLoading => _isLoading;

  bool get isPaginationLoading =>
      _isPaginationLoading;

  bool get hasMore => _hasMore;

  File? get selectedImage => _selectedImage;

  List<UserModel> get users => _users;

  List<UserModel> get filteredUsers =>
      _filteredUsers;

  SortType get sortType => _sortType;

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
  try {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;

    notifyListeners();

    String imageUrl = '';

     if (_selectedImage != null) {
      imageUrl = await _storageService
          .uploadUserImage(
        _selectedImage!,
      );
    }

    final user = UserModel(
      id: '',

      name: nameController.text.trim(),

      phone: phoneController.text.trim(),

      age: int.parse(
        ageController.text.trim(),
      ),

      imageUrl: imageUrl,

      createdAt: Timestamp.now(),
    );

    await _firestoreService.addUser(
      user,
    );

    nameController.clear();

    phoneController.clear();

    ageController.clear();

    _selectedImage = null;

    notifyListeners();
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

      _filteredUsers = List.from(_users);

      sortUsers(_sortType);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> fetchPaginatedUsers() async {
    if (_isPaginationLoading || !_hasMore) {
      return;
    }

    try {
      _isPaginationLoading = true;

      notifyListeners();

      final QuerySnapshot querySnapshot =
          await _firestoreService
              .fetchPaginatedUsers(
        lastDocument: _lastDocument,
      );

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument =
            querySnapshot.docs.last;
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
      rethrow;
    } finally {
      _isPaginationLoading = false;

      notifyListeners();
    }
  }

  void searchUsers(String query) {
    if (query.trim().isEmpty) {
      _filteredUsers = List.from(_users);
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

    sortUsers(_sortType);
  }

  void sortUsers(SortType type) {
    _sortType = type;

    if (type == SortType.ageAscending) {
      _filteredUsers.sort(
        (a, b) => a.age.compareTo(b.age),
      );
    } else {
      _filteredUsers.sort(
        (a, b) => b.age.compareTo(a.age),
      );
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

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    searchController.dispose();

    super.dispose();
  }
}