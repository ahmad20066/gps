import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      // width: 326.w,
      margin: REdgeInsets.symmetric(horizontal: 32.w),
      padding: REdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: AppColors.primaryColor, width: 2.sp),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          )),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            Icons.calendar_today_outlined,
            size: 22.h,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            "يوم السبت 05/18/2024",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
