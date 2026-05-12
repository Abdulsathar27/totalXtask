import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/views/add_users/add_user_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: Consumer<UserController>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading &&
              userProvider.filteredUsers.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
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
                    userProvider.filteredUsers.isEmpty
                        ? const Center(
                            child: Text(
                              'No Users Found',
                            ),
                          )
                        : ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            itemCount: userProvider
                                .filteredUsers.length,
                            itemBuilder:
                                (context, index) {
                              final user = userProvider
                                  .filteredUsers[index];

                              return Card(
                                margin:
                                    const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
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
            ],
          );
        },
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
            await context
                .read<UserController>()
                .fetchUsers();
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}