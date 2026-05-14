import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> addUser(UserModel user) async {
    try {
      final DocumentReference docRef = usersCollection.doc();

      final UserModel newUser = UserModel(
        id: docRef.id,

        ownerId: user.ownerId,

        name: user.name,

        phone: user.phone,

        age: user.age,

        imageUrl: user.imageUrl,

        createdAt: user.createdAt,
      );

      await docRef.set(newUser.toMap());
    } catch (e) {
      print('FirestoreService error: $e'); // add this line
      rethrow;
    }
  }

  Future<List<UserModel>> fetchUsers(String ownerId) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection
              .where('ownerId', isEqualTo: ownerId)
              .orderBy('createdAt', descending: true)
              .get();

      if (querySnapshot.docs.isEmpty) {
        // Compatibility path for older docs that may not have `createdAt`.
        querySnapshot =
            await usersCollection.where('ownerId', isEqualTo: ownerId).get();
      }

      final List<UserModel> users =
          querySnapshot.docs.map((doc) {
            return UserModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

      return users;
    } catch (e) {
      print('FirestoreService error: $e'); // add this line
      rethrow;
    }
  }

  Future<QuerySnapshot> fetchPaginatedUsers({
    required String ownerId,

    DocumentSnapshot? lastDocument,

    int limit = 10,
  }) async {
    try {
      Query query = usersCollection
          .where('ownerId', isEqualTo: ownerId)
          .orderBy('createdAt', descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      query = query.limit(limit);

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty && lastDocument == null) {
        // Compatibility path for older docs that may not have `createdAt`.
        querySnapshot =
            await usersCollection
                .where('ownerId', isEqualTo: ownerId)
                .limit(limit)
                .get();
      }

      return querySnapshot;
    } catch (e) {
      print('FirestoreService error: $e'); // add this line
      rethrow;
    }
  }
}
