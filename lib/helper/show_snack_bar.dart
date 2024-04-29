import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
