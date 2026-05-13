import 'package:cached_network_image/cached_network_image.dart';
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
        leading: CachedNetworkImage(
          imageUrl: user.imageUrl,
          imageBuilder:
              (context, imageProvider) {
            return CircleAvatar(
              radius: 30,
              backgroundImage: imageProvider,
            );
          },
          placeholder: (context, url) {
            return const CircleAvatar(
              radius: 30,
              child: CircularProgressIndicator(),
            );
          },
          errorWidget:
              (context, url, error) {
            return const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
              ),
            );
          },
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