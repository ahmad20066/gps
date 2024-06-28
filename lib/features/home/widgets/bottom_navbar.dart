import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
            ),
          ),
          Obx(() {
            return Container(
              color: Colors.transparent,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    List.generate(bottomNavController.labels.length, (index) {
                  bool isSelected =
                      bottomNavController.selectedIndex.value == index;
                  return GestureDetector(
                    onTap: () {
                      bottomNavController.changeTabIndex(index);
                    },
                    child: AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: !isSelected
                          ? Alignment.bottomCenter
                          : Alignment(0, -1),
                      // margin: EdgeInsets.only(top: isSelected ? 0 : 20.h),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: !isSelected
                                ? null
                                : [
                                    BoxShadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 4,
                                        offset: Offset(0, -4))
                                  ]),
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColors.primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bottomNavController.labels[index]['icon'],
                                color: Colors.white,
                                size: 30.sp,
                              ),
                              Text(
                                bottomNavController.labels[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
