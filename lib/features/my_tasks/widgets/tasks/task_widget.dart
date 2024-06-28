import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/common/widgets/custom_row.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final Function(LatLng, TaskModel) onShowOnMap;

  const TaskWidget({super.key, required this.task, required this.onShowOnMap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: REdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
      height: 200.h,
      decoration: BoxDecoration(
        color: Color.fromRGBO(243, 243, 243, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomRow(
                        value: task.customer_name, icon: Icons.face_outlined),
                    SizedBox(height: 7.h),
                    CustomRow(
                        value: task.location_text,
                        icon: Icons.location_on_outlined),
                    SizedBox(height: 7.h),
                    CustomRow(
                        value: task.customer_number,
                        icon: Icons.phone_outlined),
                    SizedBox(height: 7.h),
                    CustomRow(value: task.debt, icon: Icons.local_atm_outlined),
                  ],
                ),
              ),
              // Spacer(),
              Text(
                task.tag,
                style:
                    TextStyle(color: AppColors.primaryColor, fontSize: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: 169.w,
                height: 40.h,
                onTap: () => onShowOnMap(LatLng(34.052235, -118.243683), task),
                text: "عرض على الخريطة",
                prefix: Icon(
                  Icons.assistant_direction_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5.w),
              Obx(() => task.loading!.value
                  ? SizedBox(
                      width: 119.w,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CustomButton(
                      width: 119.w,
                      height: 40.h,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      hasBorder: true,
                      textColor: AppColors.primaryColor,
                      onTap: () async {
                        await Get.find<BottomNavController>().startVisit(task);
                      },
                      text: "بدء الزيارة",
                      prefix: Icon(
                        Icons.local_shipping_outlined,
                        color: AppColors.primaryColor,
                      ),
                    )),
            ],
          ),
        ],
      ),
    );
  }
}
