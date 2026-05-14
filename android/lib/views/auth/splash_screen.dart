import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/splash_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';
import 'package:totalxtask/core/constant/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<SplashController>()
          .checkLogin(context);
    });

    return Scaffold(
      backgroundColor:
          AppColors.black,

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width:
                  AppSizes.splashLogoSize,

              height:
                  AppSizes.splashLogoSize,

              decoration: BoxDecoration(
                color:
                    AppColors.white,

                borderRadius:
                    BorderRadius.circular(
                  AppSizes
                      .splashLogoRadius,
                ),
              ),

              child: const Icon(
                Icons.people,

                size:
                    AppSizes.splashIconSize,

                color:
                    AppColors.black,
              ),
            ),

            const SizedBox(
              height:
                  AppSizes.splashSpacing,
            ),

            const Text(
              AppStrings.appName,

              style: TextStyle(
                fontSize:
                    AppSizes.splashTitleSize,

                fontWeight:
                    FontWeight.w700,

                color:
                    AppColors.white,

                letterSpacing: 1,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              AppStrings.splashSubtitle,

              style: TextStyle(
                fontSize: 15,

                fontWeight:
                    FontWeight.w400,

                color:
                    AppColors.hintGrey,
              ),
            ),

            const SizedBox(
              height:
                  AppSizes
                      .splashLoaderSpacing,
            ),

            const CircularProgressIndicator(
              color:
                  AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}