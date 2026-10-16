import 'package:flutter/material.dart';

class SnackbarUtil {
  // Private constructor prevents instantiation, enforcing static usage
  SnackbarUtil._();

  static void show(
    BuildContext contextObject,
    String messageText,
    IconData iconData,
  ) {
    ScaffoldMessenger.of(contextObject).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(messageText)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF333333),
      ),
    );
  }
}
