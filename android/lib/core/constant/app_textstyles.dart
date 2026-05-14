import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';

class AppTextStyles {
  static const TextStyle screenTitle = TextStyle(
    fontSize: 24,

    fontWeight: FontWeight.w700,

    color: AppColors.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,

    fontWeight: FontWeight.w600,

    color: AppColors.black,
  );

  static const TextStyle loginTitle = TextStyle(
    fontSize: 32,

    fontWeight: FontWeight.bold,

    color: AppColors.black,
  );

  static const TextStyle loginSubtitle = TextStyle(
    fontSize: 16,

    color: AppColors.hintGrey,

    height: 1.5,
  );
  static const TextStyle
    locationText = TextStyle(
      color: AppColors.white,

      fontSize:
          AppSizes.locationFontSize,

      fontWeight:
          FontWeight.w500,
    );

static const TextStyle
    usersListTitle = TextStyle(
      fontSize:
          AppSizes.usersTitleSize,

      fontWeight:
          FontWeight.w700,

      color:
          AppColors.usersTitleColor,
    );

    static const TextStyle
    userNameText = TextStyle(
      fontSize: 18,

      fontWeight:
          FontWeight.w600,

      color:
          AppColors.textDark,
    );

static const TextStyle
    userSubText = TextStyle(
      fontSize: 14,

      fontWeight:
          FontWeight.w400,

      color:
          Colors.black54,
    );
}
