import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async {
    try {
      await usersCollection.doc(user.id).set(
            user.toMap(),
          );
    } catch (e) {
      rethrow;
    }
  }
}