import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/auth_controller.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
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
        if (userProvider.filteredUsers.isEmpty &&
            !userProvider.isPaginationLoading) {
          Future.microtask(() async {
            userProvider.resetPagination();

            await userProvider
                .fetchPaginatedUsers();
          });
        }

        return Scaffold(
          backgroundColor:
              const Color(0xFFF1F1F1),

          floatingActionButtonLocation:
              FloatingActionButtonLocation
                  .endFloat,

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 36,
              right: 6,
            ),

            child: SizedBox(
              width: 58,
              height: 58,

              child: FloatingActionButton(
                backgroundColor:
                    AppColors.black,

                elevation: 3,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    100,
                  ),
                ),

                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AddUserScreen(),
                    ),
                  );

                  if (context.mounted) {
                    userProvider
                        .resetPagination();

                    await userProvider
                        .fetchPaginatedUsers();
                  }
                },

                child: const Icon(
                  Icons.add,

                  size: 30,

                  color:
                      AppColors.white,
                ),
              ),
            ),
          ),

          body: SafeArea(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 10,
                    bottom: 14,
                  ),

                  decoration:
                      const BoxDecoration(
                    color: AppColors.black,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,

                                color:
                                    AppColors
                                        .white,

                                size: 17,
                              ),

                              SizedBox(
                                width: 4,
                              ),

                              Text(
                                'Nilambur',

                                style:
                                    TextStyle(
                                  color:
                                      AppColors
                                          .white,

                                  fontSize:
                                      15,

                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),
                            ],
                          ),

                          IconButton(
                            onPressed:
                                () async {
                              try {
                                await context
                                    .read<
                                        AuthController>()
                                    .signOut();

                                if (context
                                    .mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              const LoginScreen(),
                                    ),
                                    (
                                      route,
                                    ) =>
                                        false,
                                  );
                                }
                              } catch (e) {
                                SnackbarHelper
                                    .showErrorSnackBar(
                                  context:
                                      context,

                                  message:
                                      'Logout failed',
                                );
                              }
                            },

                            icon:
                                const Icon(
                              Icons.logout,

                              size: 23,

                              color:
                                  AppColors
                                      .white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child:
                                SizedBox(
                              height: 46,

                              child:
                                  CustomSearchBar(
                                controller:
                                    userProvider
                                        .searchController,

                                onChanged:
                                    (
                                      value,
                                    ) {
                                  userProvider
                                      .searchUsers(
                                    value,
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context:
                                    context,

                                backgroundColor:
                                    Colors
                                        .transparent,

                                builder: (_) {
                                  return const SortBottomSheet();
                                },
                              );
                            },

                            child:
                                Container(
                              width: 46,
                              height: 46,

                              decoration:
                                  BoxDecoration(
                                color:
                                    AppColors
                                        .black,

                                border:
                                    Border.all(
                                  color:
                                      AppColors
                                          .hintGrey,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child:
                                  const Icon(
                                Icons.tune,

                                size: 20,

                                color:
                                    AppColors
                                        .white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  child: Text(
                    'Users Lists',

                    style: TextStyle(
                      fontSize: 17,

                      fontWeight:
                          FontWeight.w700,

                      color:
                          Color(0xFF4F4F4F),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Expanded(
                  child:
                      userProvider
                                  .filteredUsers
                                  .isEmpty &&
                              userProvider
                                  .isPaginationLoading
                          ? const Center(
                              child:
                                  CircularProgressIndicator(),
                            )
                          : RefreshIndicator(
                              onRefresh:
                                  () async {
                                userProvider
                                    .resetPagination();

                                await userProvider
                                    .fetchPaginatedUsers();
                              },

                              child:
                                  NotificationListener<
                                      ScrollNotification>(
                                onNotification:
                                    (
                                      scrollInfo,
                                    ) {
                                  if (scrollInfo
                                          .metrics
                                          .pixels >=
                                      scrollInfo
                                              .metrics
                                              .maxScrollExtent -
                                          200) {
                                    userProvider
                                        .fetchPaginatedUsers();
                                  }

                                  return false;
                                },

                                child:
                                    userProvider
                                            .filteredUsers
                                            .isEmpty
                                        ? const EmptyStateWidget(
                                            icon:
                                                Icons.people_outline,

                                            title:
                                                'No Users Found',

                                            subtitle:
                                                'Add your first user to get started',
                                          )
                                        : ListView.builder(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),

                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal:
                                                  18,
                                            ),

                                            itemCount:
                                                userProvider.filteredUsers.length +
                                                    (userProvider.isPaginationLoading
                                                        ? 1
                                                        : 0),

                                            itemBuilder:
                                                (
                                                  context,
                                                  index,
                                                ) {
                                              if (index ==
                                                  userProvider
                                                      .filteredUsers
                                                      .length) {
                                                return const Padding(
                                                  padding:
                                                      EdgeInsets.all(
                                                    16,
                                                  ),

                                                  child:
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }

                                              final user =
                                                  userProvider
                                                          .filteredUsers[
                                                      index];

                                              return UserCard(
                                                user:
                                                    user,
                                              );
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