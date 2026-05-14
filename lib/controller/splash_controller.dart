import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/views/auth/login_screen.dart';
import 'package:totalxtask/views/home/home_screen.dart';

class SplashController extends ChangeNotifier {
  Future<void> checkLogin(
    BuildContext context,
  ) async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      final user =
          FirebaseAuth
              .instance
              .currentUser;

      if (!context.mounted) {
        return;
      }

      if (user != null) {
        Navigator.pushReplacement(
          context,

          MaterialPageRoute(
            builder:
                (_) =>
                    const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,

          MaterialPageRoute(
            builder:
                (_) =>
                    const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder:
              (_) =>
                  const LoginScreen(),
        ),
      );
    }
  }
}