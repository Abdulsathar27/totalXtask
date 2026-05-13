import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> addUser(UserModel user) async {
  try {
    final DocumentReference docRef =
        usersCollection.doc();

    final UserModel newUser = UserModel(
      id: docRef.id,

      name: user.name,

      phone: user.phone,

      age: user.age,

      imageUrl: user.imageUrl,

      createdAt: user.createdAt,
    );

    await docRef.set(
      newUser.toMap(),
    );
  } catch (e) {
    rethrow;
  }
}

  Future<List<UserModel>> fetchUsers() async {
    try {
      final QuerySnapshot querySnapshot = await usersCollection
          .orderBy('createdAt', descending: true)
          .get();

      final List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> fetchPaginatedUsers({
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) async {
    try {
      Query query = usersCollection.orderBy('createdAt', descending: true);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      query = query.limit(limit);

      final QuerySnapshot querySnapshot = await query.get();

      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
