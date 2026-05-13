import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/auth_controller.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';
import 'package:totalxtask/core/constant/app_spacing.dart';
import 'package:totalxtask/core/constant/app_strings.dart';
import 'package:totalxtask/core/utils/snackbar_helper.dart';
import 'package:totalxtask/views/home/home_screen.dart';
import 'package:totalxtask/widgets/google_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal:
                AppSpacing.screenPadding,
          ),

          child: Consumer<AuthController>(
            builder: (
              context,
              authProvider,
              child,
            ) {
              return SizedBox(
                height:
                    MediaQuery.of(context)
                            .size
                            .height -
                        40,

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [
                    Image.asset(
                      AppStrings.totalXLogo,

                      height:
                          AppSizes.logoHeight,

                      fit: BoxFit.contain,
                    ),

                    const SizedBox(
                      height:
                          AppSpacing
                              .extraLargeSpacing,
                    ),

                    Text(
                      AppStrings
                          .welcomeBack,

                      style: Theme.of(
                            context,
                          )
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                    ),

                    const SizedBox(
                      height:
                          AppSpacing
                              .mediumSpacing,
                    ),

                    const Text(
                      AppStrings
                          .loginSubtitle,

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 16,

                        color:
                            AppColors
                                .hintGrey,

                        height: 1.5,
                      ),
                    ),

                    const SizedBox(
                      height: 48,
                    ),

                    GoogleSignInButton(
                      isLoading:
                          authProvider
                              .isLoading,

                      onPressed:
                          () async {
                        try {
                          await authProvider
                              .signInWithGoogle();

                          if (!context
                              .mounted) {
                            return;
                          }

                          final userProvider =
                              context.read<
                                  UserController>();

                          userProvider
                              .resetPagination();

                          await userProvider
                              .fetchPaginatedUsers();

                          if (!context
                              .mounted) {
                            return;
                          }

                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      const HomeScreen(),
                            ),
                          );
                        } catch (e) {
                          if (!context
                              .mounted) {
                            return;
                          }

                          SnackbarHelper
                              .showErrorSnackBar(
                            context:
                                context,

                            message:
                                AppStrings
                                    .googleSignInFailed,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}