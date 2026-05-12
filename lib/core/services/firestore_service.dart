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

  Future<List<UserModel>> fetchUsers() async {
    try {
      final QuerySnapshot querySnapshot =
          await usersCollection
              .orderBy(
                'createdAt',
                descending: true,
              )
              .get();

      final List<UserModel> users =
          querySnapshot.docs.map((doc) {
        return UserModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }
}