import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/common/widgets/end_work_widget.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class StartShiftPage extends StatelessWidget {
  const StartShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    return Scaffold(
      appBar: CustomAppBar(
        text: "مهامي",
        actions: [EndWorkWidget()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text(
            "صباح الخير",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "اسم المندوب",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "نتمنى لك يوم عمل سعيد ",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16.sp),
          ),
          SizedBox(
            height: 30.h,
          ),
          Image.asset("assets/images/welcome.png"),
          SizedBox(
            height: 40.h,
          ),
          Obx(() => controller.startStatus.value == RequestStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  onTap: () {
                    controller.startWork();
                  },
                  text: "بدء العمل",
                  width: 326.w,
                  height: 40.h,
                )),
          SizedBox(
            height: 90.h,
          )
        ],
      ),
    );
  }
}
