import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/date_container.dart';
import 'package:gps_module/common/widgets/end_work_widget.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/my_tasks/widgets/tasks/tasks_list.dart';
import 'package:gps_module/features/statistics/controllers/statistics_controller.dart';
import 'package:gps_module/features/statistics/widgetss/stat_widget.dart';
import 'package:intl/intl.dart';

class Statisticspage extends StatelessWidget {
  const Statisticspage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());
    return Scaffold(
      appBar: const CustomAppBar(
        text: "الاحصائيات",
        actions: [
          EndWorkWidget(),
        ],
      ),
      body: Obx(() {
        if (controller.status.value == RequestStatus.onerror) {
          return Center(child: Text("Failed to load data"));
        } else if (controller.stats == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              DateContainer(),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedBuilder(
                    animation: controller.successAnimation,
                    builder: (context, child) {
                      return StatWidget(
                        title: "ناجحة",
                        color: AppColors.primaryColor,
                        value: controller.successAnimation.value
                            .toInt()
                            .toString(),
                        icon: Icons.check,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller.failureAnimation,
                    builder: (context, child) {
                      return StatWidget(
                        title: "غير ناجحة",
                        color: Color.fromRGBO(198, 57, 59, 1),
                        value: controller.failureAnimation.value
                            .toInt()
                            .toString(),
                        icon: Icons.close,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller.pendingAnimation,
                    builder: (context, child) {
                      return StatWidget(
                        title: "غير مكتملة",
                        color: Color.fromRGBO(207, 162, 48, 1),
                        value: controller.pendingAnimation.value
                            .toInt()
                            .toString(),
                        icon: Icons.pending_outlined,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedBuilder(
                    animation: controller.collectedAmountAnimation,
                    builder: (context, child) {
                      return StatWidget(
                        title: "المبالغ المستحصلة",
                        color: Color.fromRGBO(165, 64, 109, 1),
                        value: NumberFormat.decimalPattern()
                            .format(controller.collectedAmountAnimation.value),
                        icon: Icons.price_check_outlined,
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller.totalSalesAnimation,
                    builder: (context, child) {
                      return StatWidget(
                        title: "مجموع المبيعات",
                        color: Color.fromRGBO(64, 160, 165, 1),
                        value: NumberFormat.decimalPattern()
                            .format(controller.totalSalesAnimation.value),
                        icon: Icons.conveyor_belt,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              TasksList(
                  tasks: <TaskModel>[
                // TaskModel(
                //     id: 1,
                //     name: "اسم الزبون",
                //     phone: "092222",
                //     location_text: "نص الموقع",
                //     location: "",
                //     totalDue: "مجموع الديون",
                //     type: "VIP")
              ].obs)
            ],
          );
        }
      }),
    );
  }
}
