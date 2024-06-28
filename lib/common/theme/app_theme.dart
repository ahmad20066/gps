import 'package:flutter/material.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class AppTheme {
  static getTheme() => ThemeData(
      useMaterial3: false,
      fontFamily: "Cairo",
      colorScheme:
          ColorScheme.fromSwatch().copyWith(primary: AppColors.primaryColor));
}
