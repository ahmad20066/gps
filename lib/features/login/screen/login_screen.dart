import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/background_image.dart';
import 'package:gps_module/features/login/controllers/login_controller.dart';
import 'package:gps_module/features/login/widgets/custom_bottom_sheet.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      bottomSheet: Obx(() => CustomBottomSheet(
            height: controller.height.value,
            child: controller.child.value.value,
          )),
      // backgroundColor: AppColors.primaryColor,
      body: BackGroundImage(),
    );
  }
}
