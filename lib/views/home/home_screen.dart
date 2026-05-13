import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/auth_controller.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_spacing.dart';
import 'package:totalxtask/core/utils/snackbar_helper.dart';
import 'package:totalxtask/views/add_users/add_user_screen.dart';
import 'package:totalxtask/views/auth/login_screen.dart';
import 'package:totalxtask/widgets/custom_search_bar.dart';
import 'package:totalxtask/widgets/empty_widget.dart';
import 'package:totalxtask/widgets/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userProvider, child) {
        if (userProvider.filteredUsers.isEmpty &&
            !userProvider.isPaginationLoading) {
          Future.microtask(() async {
            userProvider.resetPagination();
            await userProvider.fetchPaginatedUsers();
          });
        }

        return Scaffold(
          backgroundColor: const Color(0xFFEEEEEE),

          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.black,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddUserScreen(),
                ),
              );
              if (context.mounted) {
                userProvider.resetPagination();
                await userProvider.fetchPaginatedUsers();
              }
            },
            child: const Icon(Icons.add, color: AppColors.scaffoldBackground),
          ),

          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: location row
                Container(
                  color: AppColors.black,
                  padding: const EdgeInsets.only(
                    left: AppSpacing.screenPadding,
                    right: AppSpacing.screenPadding,
                    top: 16,
                    bottom: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.location_on, color: AppColors.scaffoldBackground, size: 20),
                              SizedBox(width: 4),
                              Text(
                                'Nilambur',
                                style: TextStyle(
                                  color: AppColors.scaffoldBackground,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {
                              try {
                                await context.read<AuthController>().signOut();
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                }
                              } catch (e) {
                                SnackbarHelper.showErrorSnackBar(
                                  context: context,
                                  message: 'Logout failed',
                                );
                              }
                            },
                            icon: const Icon(Icons.logout, color: AppColors.scaffoldBackground),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Search + filter row
                      Row(
                        children: [
                          Expanded(
                            child: CustomSearchBar(
                              controller: userProvider.searchController,
                              onChanged: (value) {
                                userProvider.searchUsers(value);
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.mediumSpacing),
                          PopupMenuButton<SortType>(
                            onSelected: (SortType value) {
                              userProvider.sortUsers(value);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: SortType.ageAscending,
                                child: Text('Age Ascending'),
                              ),
                              const PopupMenuItem(
                                value: SortType.ageDescending,
                                child: Text('Age Descending'),
                              ),
                            ],
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                border: Border.all(color:AppColors.hintGrey ),
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.inputRadius,
                                ),
                              ),
                              child: const Icon(Icons.tune, color: AppColors.scaffoldBackground),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // "Users Lists" label
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  child: const Text(
                    'Users Lists',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cardShadow,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // List area
                Expanded(
                  child: userProvider.filteredUsers.isEmpty &&
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
                            child: userProvider.filteredUsers.isEmpty
                                ? const EmptyStateWidget(
                                    icon: Icons.people_outline,
                                    title: 'No Users Found',
                                    subtitle:
                                        'Add your first user to get started',
                                  )
                                : ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.screenPadding,
                                    ),
                                    itemCount:
                                        userProvider.filteredUsers.length +
                                            (userProvider.isPaginationLoading
                                                ? 1
                                                : 0),
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          userProvider.filteredUsers.length) {
                                        return const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: CircularProgressIndicator(),
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