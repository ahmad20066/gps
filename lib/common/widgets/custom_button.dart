import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Widget? prefix;
  final double height, width;
  final Color color, textColor;
  final bool hasBorder;
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.prefix,
      this.hasBorder = false,
      this.color = AppColors.primaryColor,
      this.textColor = Colors.white,
      this.height = 40,
      this.width = 294});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: hasBorder
                ? Border.all(color: AppColors.primaryColor, width: 2)
                : null),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            if (prefix != null) prefix!,
            if (prefix != null)
              SizedBox(
                width: 10.w,
              ),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 12.sp),
            ),
            // if (prefix != null)
            //   SizedBox(
            //     width: 10.w,
            //   ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
