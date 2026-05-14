import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';

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
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withAlpha(2),

            blurRadius: 6,

            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        onChanged: onChanged,

        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),

        decoration: InputDecoration(
          hintText: 'Search users',

          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.hintGrey,
            fontWeight: FontWeight.w400,
          ),

          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: AppColors.hintGrey,
          ),

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 12,
          ),
        ),
      ),
    );
  }
}