import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';

class SortTile
    extends StatelessWidget {
  final String title;

  final VoidCallback onTap;

  const SortTile({
    required this.title,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),

      onTap: onTap,

      child: Container(
        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        decoration: BoxDecoration(
          color:
              const Color(0xFFF5F5F5),

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Text(
          title,

          style: const TextStyle(
            fontSize: 16,
            fontWeight:
                FontWeight.w500,
            color:
                AppColors.textDark,
          ),
        ),
      ),
    );
  }
}