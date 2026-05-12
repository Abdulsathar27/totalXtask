import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/services/auth_service.dart';

class Authcontroller extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool _isLoading = false;

  User? _user;

  bool get isLoading => _isLoading;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Authcontroller() {
    _user = authService.currentUser;
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;

      notifyListeners();

      final UserCredential? userCredential =
          await authService.signInWithGoogle();

      if (userCredential != null) {
        _user = userCredential.user;
      }

      return userCredential != null;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;

      notifyListeners();

      await authService.signOut();

      _user = null;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}