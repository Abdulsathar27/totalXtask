import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser =
          await googleSignIn.authenticate();

      final GoogleSignInClientAuthorization? googleAuth =
          await googleUser.authorizationClient
              .authorizationForScopes(
        ['email'],
      );

      final AuthCredential credential =
          GoogleAuthProvider.credential(
        idToken: googleUser.authentication.idToken,
        accessToken: googleAuth?.accessToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(
        credential,
      );

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();

    await firebaseAuth.signOut();
  }
}