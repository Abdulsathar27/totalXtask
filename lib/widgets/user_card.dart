import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';

import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.035,
            ),

            blurRadius: 10,

            spreadRadius: 0,

            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: user.imageUrl,

            imageBuilder:
                (
                  context,
                  imageProvider,
                ) {
              return CircleAvatar(
                radius: 32,

                backgroundImage:
                    imageProvider,
              );
            },

            placeholder:
                (
                  context,
                  url,
                ) {
              return const CircleAvatar(
                radius: 32,

                backgroundColor:
                    AppColors.borderGrey,

                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },

            errorWidget:
                (
                  context,
                  url,
                  error,
                ) {
              return const CircleAvatar(
                radius: 32,

                backgroundColor:
                    AppColors.borderGrey,

                child: Icon(
                  Icons.person,

                  size: 28,

                  color:
                      AppColors.hintGrey,
                ),
              );
            },
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                Text(
                  user.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight.w600,

                    color:
                        AppColors.textDark,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  'Age: ${user.age}',

                  style: const TextStyle(
                    fontSize: 14,

                    fontWeight:
                        FontWeight.w400,

                    color:
                        Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}