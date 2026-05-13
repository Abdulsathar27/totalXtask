import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtask/controller/user_controller.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/utils/snackbar_helper.dart';
import 'package:totalxtask/core/utils/validators.dart';
import 'package:totalxtask/widgets/custom_textfield.dart';

import 'package:totalxtask/widgets/primary_button.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Add A New User',

          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
      ),

      body: Consumer<UserController>(
        builder: (context, userProvider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              child: Form(
                key: userProvider.formKey,

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.white,

                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),

                        blurRadius: 10,

                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await userProvider.pickImage();
                        },

                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: const Color(0xFFE9E9E9),

                                image: userProvider.selectedImage != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(
                                            userProvider.selectedImage!.path,
                                          ),
                                        ),

                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),

                              child: userProvider.selectedImage == null
                                  ? const Icon(
                                      Icons.person,

                                      size: 60,

                                      color: AppColors.hintGrey,
                                    )
                                  : null,
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,

                              child: Container(
                                padding: const EdgeInsets.all(8),

                                decoration: const BoxDecoration(
                                  color: AppColors.black,

                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.camera_alt,

                                  size: 18,

                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      CustomTextField(
                        controller: userProvider.nameController,

                        hintText: 'Full Name',

                        validator: Validators.validateName,
                      ),

                      const SizedBox(height: 18),

                      CustomTextField(
                        controller: userProvider.phoneController,

                        hintText: 'Phone Number',

                        keyboardType: TextInputType.phone,

                        validator: Validators.validatePhone,
                      ),

                      const SizedBox(height: 18),

                      CustomTextField(
                        controller: userProvider.ageController,

                        hintText: 'Age',

                        keyboardType: TextInputType.number,

                        validator: Validators.validateAge,
                      ),

                      const SizedBox(height: 34),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 54,

                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.black,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                child: const Text(
                                  'Cancel',

                                  style: TextStyle(
                                    color: AppColors.black,

                                    fontSize: 16,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: PrimaryButton(
                              text: 'Save',

                              isLoading: userProvider.isLoading,

                              onPressed: () async {
                                try {
                                  await userProvider.addUser();
                                  if (!context.mounted) return;

                                  if (context.mounted) {
                                    SnackbarHelper.showSuccessSnackBar(
                                      context: context,

                                      message: 'User Added Successfully',
                                    );

                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  SnackbarHelper.showErrorSnackBar(
                                    context: context,

                                    message: 'Something went wrong',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
