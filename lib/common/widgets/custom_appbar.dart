import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? leading;
  final List<Widget> actions;
  const CustomAppBar(
      {super.key, required this.text, this.leading, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80.w,
      titleSpacing: 0,
      title: Text(
        text,
        style: TextStyle(fontSize: 16.sp),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      actions: actions,
      leading: leading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 62.h);
}
