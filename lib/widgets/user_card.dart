import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            user.imageUrl,
          ),
        ),
        title: Text(
          user.name,
        ),
        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              user.phone,
            ),
            Text(
              'Age: ${user.age}',
            ),
          ],
        ),
      ),
    );
  }
}