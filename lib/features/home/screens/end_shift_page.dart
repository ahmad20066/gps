import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class EndShiftPage extends StatelessWidget {
  const EndShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    return Scaffold(
      appBar: CustomAppBar(text: "انهاء العمل"),
      body: SizedBox(
        // height: 307.h,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "هل أنت متأكد من إنهاء العمل؟",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 16.sp),
            ),
            SizedBox(
              height: 10.h,
              width: double.infinity,
            ),
            Image.asset("assets/images/stop.png"),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => controller.endStatus.value == RequestStatus.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onTap: () {
                          controller.endWork();
                        },
                        text: "نعم",
                        width: 147.w,
                        height: 40.h,
                        color: Color.fromRGBO(198, 57, 59, 1),
                      )),
                SizedBox(
                  width: 20.w,
                ),
                CustomButton(
                  onTap: () {
                    controller.cancelEndWork();
                  },
                  text: "لا",
                  width: 147.w,
                  height: 40.h,
                ),
              ],
            ),
            SizedBox(
              height: 80.h,
            )
          ],
        ),
      ),
    );
  }
}
