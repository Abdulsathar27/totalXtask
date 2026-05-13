import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_sizes.dart';

class SnackbarHelper {
  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static OutlineInputBorder inputBorder(
  Color color,
) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(
      AppSizes.mediumRadius,
    ),
    borderSide:
        BorderSide(color: color),
  );
}
}