import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/auth_controller.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/views/add_users/add_user_screen.dart';


import '../auth/login_screen.dart';

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
          appBar: AppBar(
            title: const Text(
              'Users',
            ),
            actions: [
              PopupMenuButton<SortType>(
                onSelected: (SortType value) {
                  userProvider.sortUsers(value);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: SortType.ageAscending,
                    child: Text(
                      'Age Ascending',
                    ),
                  ),
                  const PopupMenuItem(
                    value: SortType.ageDescending,
                    child: Text(
                      'Age Descending',
                    ),
                  ),
                ],
              ),

              IconButton(
                onPressed: () async {
                  try {
                    await context
                        .read<AuthController>()
                        .signOut();

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller:
                      userProvider.searchController,
                  onChanged: (value) {
                    userProvider.searchUsers(
                      value,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search users',
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              Expanded(
                child:
                    userProvider.filteredUsers.isEmpty &&
                            userProvider
                                .isPaginationLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              userProvider
                                  .resetPagination();

                              await userProvider
                                  .fetchPaginatedUsers();
                            },
                            child:
                                NotificationListener<
                                    ScrollNotification>(
                              onNotification:
                                  (scrollInfo) {
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
                              child: ListView.builder(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: userProvider
                                        .filteredUsers
                                        .length +
                                    (userProvider
                                            .isPaginationLoading
                                        ? 1
                                        : 0),
                                itemBuilder:
                                    (context, index) {
                                  if (index ==
                                      userProvider
                                          .filteredUsers
                                          .length) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.all(
                                        16,
                                      ),
                                      child: Center(
                                        child:
                                            CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final user =
                                      userProvider
                                              .filteredUsers[
                                          index];

                                  return Card(
                                    margin:
                                        const EdgeInsets.only(
                                      bottom: 16,
                                    ),
                                    child: ListTile(
                                      leading:
                                          CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(
                                          user.imageUrl,
                                        ),
                                      ),
                                      title: Text(
                                        user.name,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          Text(
                                            user.phone,
                                          ),
                                          Text(
                                            'Age: ${user.age}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
              ),
            ],
          ),
          floatingActionButton:
              FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AddUserScreen(),
                ),
              );

              if (context.mounted) {
                userProvider.resetPagination();

                await userProvider
                    .fetchPaginatedUsers();
              }
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}