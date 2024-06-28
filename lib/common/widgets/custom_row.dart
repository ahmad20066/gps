import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomRow extends StatelessWidget {
  final String value;
  final IconData icon;
  const CustomRow({super.key, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 12.sp,
          ),
        )
      ],
    );
  }
}
