import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/date_container.dart';
import 'package:gps_module/common/widgets/end_work_widget.dart';
import 'package:gps_module/features/my_tasks/controllers/my_tasks_screen_controller.dart';
import 'package:gps_module/features/my_tasks/pages/list_page.dart';
import 'package:gps_module/features/my_tasks/pages/map_page.dart';
import 'package:gps_module/features/my_tasks/widgets/custom_tabbar.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyTaskaScreenController());
    return Scaffold(
      appBar: CustomAppBar(
        text: "مهامي",
        actions: [EndWorkWidget()],
      ),
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Positioned.fill(
              child: TabBarView(
                controller: controller.tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MapPage(),
                  ListPage(),
                ],
              ),
            ),
            IgnorePointer(
              ignoring: false,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const DateContainer(),
                  CustomTabBar(controller: controller.tabController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
