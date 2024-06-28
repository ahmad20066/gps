import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/loader.dart';
import 'package:gps_module/common/widgets/no_data.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/my_tasks/controllers/tasks_controller.dart';
import 'package:gps_module/features/my_tasks/widgets/custom_search_bar.dart';
import 'package:gps_module/features/my_tasks/widgets/tasks/tasks_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TasksController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 140.h,
            ),
            CustomSearchBar(
                controller: controller.searchController,
                onchanged: (v) {
                  controller.search();
                }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              switch (controller.tasksStatus.value) {
                case RequestStatus.loading:
                  return CustomLoader();
                case RequestStatus.nodata:
                  return NoData();
                case RequestStatus.success:
                  return TasksList(tasks: controller.tasks);
                default:
                  return SizedBox.shrink();
              }
            })
          ],
        ),
      ),
    );
  }
}
