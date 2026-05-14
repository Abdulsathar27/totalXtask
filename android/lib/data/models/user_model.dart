import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;

  final String ownerId;

  final String name;

  final String phone;

  final int age;

  final String imageUrl;

  final Timestamp createdAt;

  UserModel({
    required this.id,

    required this.ownerId,

    required this.name,

    required this.phone,

    required this.age,

    required this.imageUrl,

    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,

      'name': name,

      'phone': phone,

      'age': age,

      'imageUrl': imageUrl,

      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return UserModel(
      id: documentId,

      ownerId:
          map['ownerId'] ?? '',

      name:
          map['name'] ?? '',

      phone:
          map['phone'] ?? '',

      age:
          map['age'] ?? 0,

      imageUrl:
          map['imageUrl'] ?? '',

      createdAt:
          map['createdAt'] ??
              Timestamp.now(),
    );
  }
}