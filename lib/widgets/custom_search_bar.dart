import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_spacing.dart';


class CustomSearchBar
    extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppSpacing.inputRadius,
        ),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        onChanged: onChanged,

        decoration: const InputDecoration(
          hintText: 'Search users...',

          prefixIcon: Icon(
            Icons.search,
            color: AppColors.hintGrey,
          ),

          border: InputBorder.none,

          contentPadding:
              EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }
}