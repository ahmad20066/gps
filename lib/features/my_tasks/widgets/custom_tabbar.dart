import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/features/my_tasks/controllers/my_tasks_screen_controller.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  CustomTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: REdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
            left: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
            right: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          )),
      margin: REdgeInsets.symmetric(horizontal: 32.w),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primaryColor,
        tabs: [
          Tab(
            child: Text(
              "عرض الخريطة",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          Tab(
            child: Text(
              "عرض القائمة",
              // textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
