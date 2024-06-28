import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final onchanged;
  const CustomSearchBar({super.key, required this.controller, this.onchanged});

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
            borderRadius: BorderRadius.circular(5)),
        child: TextField(
          controller: controller,
          onChanged: onchanged,
          decoration: InputDecoration(
              contentPadding: REdgeInsets.symmetric(vertical: 8),
              border: InputBorder.none,
              hintText: "البحث عن اسم الزبون أو رقم هاتفه",
              hintStyle:
                  TextStyle(color: AppColors.primaryColor, fontSize: 12.sp),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              )),
        ));
  }
}
