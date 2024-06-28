import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';

class EndWorkWidget extends StatelessWidget {
  const EndWorkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    return Obx(() => controller.isWorking.isFalse
        ? Container(
            margin: REdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
            child:
                Obx(() => controller.logoutStatus.value == RequestStatus.loading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () {
                          controller.logout();
                        },
                        icon: Icon(Icons.logout))))
        : GestureDetector(
            onTap: () async {
              controller.showEndConfirm();
            },
            child: Container(
              alignment: Alignment.center,
              // height: 325.h,
              margin: REdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              width: 100.w,
              decoration: BoxDecoration(
                color: Color.fromRGBO(198, 57, 59, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "إنهاء العمل",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ));
  }
}
