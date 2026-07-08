import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppTopSnackBar {
  AppTopSnackBar._();

  static void success(
    BuildContext context, {
    required String message,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
        backgroundColor: const Color(0xff22C55E),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      dismissDirection: const [
        DismissDirection.up,
        DismissDirection.horizontal,
      ],
      displayDuration: const Duration(seconds: 3),
    );
  }

  static void error(
    BuildContext context, {
    required String message,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
        backgroundColor: const Color(0xffEF4444),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      dismissDirection: const [
        DismissDirection.up,
        DismissDirection.horizontal,
      ],
      displayDuration: const Duration(seconds: 4),
    );
  }

  static void warning(
    BuildContext context, {
    required String message,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
        backgroundColor: const Color(0xffF59E0B),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      dismissDirection: const [
        DismissDirection.up,
        DismissDirection.horizontal,
      ],
      displayDuration: const Duration(seconds: 3),
    );
  }

  static void info(
    BuildContext context, {
    required String message,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
        backgroundColor: const Color(0xff3B82F6),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      dismissDirection: const [
        DismissDirection.up,
        DismissDirection.horizontal,
      ],
      displayDuration: const Duration(seconds: 3),
    );
  }
}