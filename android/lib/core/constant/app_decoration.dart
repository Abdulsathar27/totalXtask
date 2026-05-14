import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';

class AppDecorations {
  static final BoxDecoration
      primaryContainer =
      BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          AppSizes.largeRadius,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(
              alpha: 0.05,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      );
      static final BoxDecoration
    homeHeaderDecoration =
    const BoxDecoration(
      color: AppColors.black,
    );

static final BoxDecoration
    filterButtonDecoration =
    BoxDecoration(
      color: AppColors.black,

      border: Border.all(
        color: AppColors.hintGrey,
      ),

      borderRadius:
          BorderRadius.circular(
        AppSizes.filterRadius,
      ),
    );
}