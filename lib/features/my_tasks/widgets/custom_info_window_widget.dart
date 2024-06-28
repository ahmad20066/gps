import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class CustomInfoWindowContent extends StatelessWidget {
  final TaskModel task;

  const CustomInfoWindowContent({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: 190.w,
      padding: REdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          _buildRow(task.customer_name, Icons.face_outlined),
          SizedBox(
            height: 7.h,
          ),
          _buildRow(task.customer_number, Icons.phone_outlined),
          SizedBox(
            height: 7.h,
          ),
          _buildRow(task.debt, Icons.local_atm_outlined),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => task.loading!.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  onTap: () {
                    Get.find<BottomNavController>().startVisit(task);
                  },
                  text: "بدأ الزيارة",
                  width: 86,
                  height: 40,
                ))
        ],
      ),
    );
  }

  Widget _buildRow(String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20.sp,
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
