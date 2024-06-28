import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';
import 'package:gps_module/features/my_tasks/controllers/visit_webview_page_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisitWebViewPage extends StatelessWidget {
  const VisitWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VisitWebviewPageController());
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        print(didPop);
        if (didPop) {
          return;
        }
        Get.find<BottomNavController>().showEndVisitConfirm();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          text: "بدء الزيارة",
          actions: [
            Obx(() => Get.find<BottomNavController>().endVisitStatus.value ==
                    RequestStatus.loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      Get.find<BottomNavController>().showEndVisitConfirm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // height: 325.h,
                      margin: REdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
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
                  ))
          ],
        ),
        body: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
