import 'package:flutter/material.dart';

/// App-wide color and text style constants
class AppColors {
  static const primary = Colors.orange;
  static const light = Color(0xFFFFF3E0);
  static const dark = Color(0xFFF57C00);
  static const text = Colors.black87;
  static const price = Colors.green;
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static const price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.price,
  );
}
