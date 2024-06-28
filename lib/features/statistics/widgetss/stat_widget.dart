import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatWidget extends StatelessWidget {
  final String title;
  final Color color;
  final String value;
  final IconData icon;
  const StatWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 25.r,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 25.sp,
            height: 1.h,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          title,
          style: TextStyle(color: color, fontSize: 12.sp, height: 1.h),
        ),
      ],
    );
  }
}
