import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_spacing.dart';


class GoogleSignInButton
    extends StatelessWidget {
  final VoidCallback onPressed;

  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed:
            isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.white,

          foregroundColor:
              AppColors.textDark,

          elevation: 0,

          side: const BorderSide(
            color: AppColors.borderGrey,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              AppSpacing.buttonRadius,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                    width: 24,
                    height: 24,
                  ),

                  const SizedBox(
                    width:
                        AppSpacing.mediumSpacing,
                  ),

                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          AppColors.textDark,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}