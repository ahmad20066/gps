import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/my_tasks/controllers/my_tasks_screen_controller.dart';
import 'package:gps_module/features/my_tasks/widgets/tasks/task_widget.dart';

class TasksList extends StatelessWidget {
  final RxList<TaskModel> tasks;
  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: tasks.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return TaskWidget(
              task: tasks[index],
              onShowOnMap: (p0, p1) =>
                  Get.find<MyTaskaScreenController>().focusOnTask(p0, p1),
            );
          },
        ));
  }
}
