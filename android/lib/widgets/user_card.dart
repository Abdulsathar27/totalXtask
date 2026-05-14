import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';
import 'package:totalxtask/core/constant/app_textstyles.dart';

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
        bottom:
            AppSizes.userCardBottomMargin,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSizes.userCardHorizontalPadding,

        vertical:
            AppSizes.userCardVerticalPadding,
      ),

      decoration:
          BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          AppSizes.userCardRadius,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(
              alpha: 0.035,
            ),

            blurRadius: 10,

            spreadRadius: 0,

            offset:
                const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl:
                user.imageUrl,

            imageBuilder:
                (
                  context,
                  imageProvider,
                ) {
              return CircleAvatar(
                radius:
                    AppSizes
                        .userAvatarRadius,

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
                radius:
                    AppSizes
                        .userAvatarRadius,

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
                radius:
                    AppSizes
                        .userAvatarRadius,

                backgroundColor:
                    AppColors.borderGrey,

                child: Icon(
                  Icons.person,

                  size:
                      AppSizes
                          .userAvatarIconSize,

                  color:
                      AppColors.hintGrey,
                ),
              );
            },
          ),

          const SizedBox(
            width:
                AppSizes.userCardSpacing,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              children: [
                Text(
                  user.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      AppTextStyles
                          .userNameText,
                ),

                const SizedBox(
                  height:
                      AppSizes
                          .userTextSpacing,
                ),

                Text(
                  'Age: ${user.age}',

                  style:
                      AppTextStyles
                          .userSubText,
                ),

                const SizedBox(
                  height:
                      AppSizes
                          .userTextSpacing,
                ),

                Text(
                  'Phone: ${user.phone}',

                  style:
                      AppTextStyles
                          .userSubText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}