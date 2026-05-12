import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/user_controller.dart';



class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add User',
        ),
      ),
      body: Consumer<UserController>(
        builder: (context, userProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: userProvider.formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await userProvider.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          userProvider.selectedImage != null
                              ? FileImage(
                                  File(
                                    userProvider
                                        .selectedImage!
                                        .path,
                                  ),
                                )
                              : null,
                      child:
                          userProvider.selectedImage ==
                                  null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                )
                              : null,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller:
                        userProvider.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter name';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller:
                        userProvider.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter phone number';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller:
                        userProvider.ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Enter age';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  userProvider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await userProvider.addUser();

                                if (context.mounted) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'User Added Successfully',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.toString(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Add User',
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}