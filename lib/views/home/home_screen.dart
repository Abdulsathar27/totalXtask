import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/auth_controller.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_decoration.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';
import 'package:totalxtask/core/constant/app_strings.dart';
import 'package:totalxtask/core/constant/app_textstyles.dart';
import 'package:totalxtask/core/utils/snackbar_helper.dart';
import 'package:totalxtask/views/add_users/add_user_screen.dart';
import 'package:totalxtask/views/auth/login_screen.dart';
import 'package:totalxtask/widgets/custom_search_bar.dart';
import 'package:totalxtask/widgets/empty_widget.dart';
import 'package:totalxtask/widgets/sort_bottom_sheet.dart';
import 'package:totalxtask/widgets/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userProvider, child) {
        final String? pendingError = userProvider.consumeError();
        if (pendingError != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) {
              return;
            }
            SnackbarHelper.showErrorSnackBar(
              context: context,
              message: pendingError,
            );
          });
        }

        if (userProvider.filteredUsers.isEmpty &&
            userProvider.hasMore &&
            !userProvider.isPaginationLoading) {
          Future.microtask(() async {
            userProvider.resetPagination();

            await userProvider.fetchPaginatedUsers();
          });
        }

        return Scaffold(
          backgroundColor: AppColors.homeBackground,

          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSizes.fabBottomPadding,

              right: AppSizes.fabRightPadding,
            ),

            child: SizedBox(
              width: AppSizes.fabSize,

              height: AppSizes.fabSize,

              child: FloatingActionButton(
                backgroundColor: AppColors.black,

                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.fabRadius),
                ),

                onPressed: () async {
                  await Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => const AddUserScreen()),
                  );

                  if (!context.mounted) {
                    return;
                  }

                  userProvider.resetPagination();

                  await userProvider.fetchPaginatedUsers();
                },

                child: const Icon(
                  Icons.add,

                  size: AppSizes.fabIconSize,

                  color: AppColors.white,
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.only(
                    left: AppSizes.homePadding,

                    right: AppSizes.homePadding,

                    top: AppSizes.headerTopPadding,

                    bottom: AppSizes.headerBottomPadding,
                  ),

                  decoration: AppDecorations.homeHeaderDecoration,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,

                                color: AppColors.white,

                                size: AppSizes.locationIconSize,
                              ),

                              const SizedBox(width: AppSizes.locationSpacing),

                              Text(
                                AppStrings.locationName,

                                style: AppTextStyles.locationText,
                              ),
                            ],
                          ),

                          IconButton(
                            onPressed: () async {
                              try {
                                final authController =
                                    context.read<AuthController>();
                                final userController =
                                    context.read<UserController>();

                                await authController.signOut();
                                userController.clearSessionState();

                                if (!context.mounted) {
                                  return;
                                }

                                Navigator.pushAndRemoveUntil(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),

                                  (route) => false,
                                );
                              } catch (e) {
                                if (!context.mounted) {
                                  return;
                                }

                                SnackbarHelper.showErrorSnackBar(
                                  context: context,

                                  message: AppStrings.logoutFailed,
                                );
                              }
                            },

                            icon: const Icon(
                              Icons.logout,

                              size: AppSizes.logoutIconSize,

                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.headerSpacing),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: AppSizes.searchBarHeight,

                              child: CustomSearchBar(
                                controller: userProvider.searchController,

                                onChanged: (value) {
                                  userProvider.searchUsers(value);
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: AppSizes.filterSpacing),

                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,

                                backgroundColor: Colors.transparent,

                                builder: (_) {
                                  return const SortBottomSheet();
                                },
                              );
                            },

                            child: Container(
                              width: AppSizes.filterButtonSize,

                              height: AppSizes.filterButtonSize,

                              decoration: AppDecorations.filterButtonDecoration,

                              child: const Icon(
                                Icons.tune,

                                size: AppSizes.filterIconSize,

                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.homeTitleSpacing),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.homePadding,
                  ),

                  child: Text(
                    AppStrings.usersList,

                    style: AppTextStyles.usersListTitle,
                  ),
                ),

                const SizedBox(height: AppSizes.listTopSpacing),

                Expanded(
                  child:
                      userProvider.filteredUsers.isEmpty &&
                              userProvider.isPaginationLoading
                          ? const Center(child: CircularProgressIndicator())
                          : RefreshIndicator(
                            onRefresh: () async {
                              userProvider.resetPagination();

                              await userProvider.fetchPaginatedUsers();
                            },

                            child: NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 200) {
                                  userProvider.fetchPaginatedUsers();
                                }

                                return false;
                              },

                              child:
                                  userProvider.filteredUsers.isEmpty
                                      ? const EmptyStateWidget(
                                        icon: Icons.people_outline,

                                        title: AppStrings.noUsersFound,

                                        subtitle: AppStrings.emptyUsersSubtitle,
                                      )
                                      : ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),

                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.homePadding,
                                        ),

                                        itemCount:
                                            userProvider.filteredUsers.length +
                                            (userProvider.isPaginationLoading
                                                ? 1
                                                : 0),

                                        itemBuilder: (context, index) {
                                          if (index ==
                                              userProvider
                                                  .filteredUsers
                                                  .length) {
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                AppSizes.loadingPadding,
                                              ),

                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }

                                          final user =
                                              userProvider.filteredUsers[index];

                                          return UserCard(user: user);
                                        },
                                      ),
                            ),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
