import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double height;
  const CustomBottomSheet({Key? key, required this.child, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: height.h,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(238, 238, 238, 1),
          boxShadow: [BoxShadow(color: AppColors.shadowColor, blurRadius: 50)],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: double.infinity,
          ),
          Divider(
            endIndent: 140.w,
            indent: 140.w,
            thickness: 5,
            color: AppColors.blackColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: child,
          ),
        ],
      ),
    );
  }
}
