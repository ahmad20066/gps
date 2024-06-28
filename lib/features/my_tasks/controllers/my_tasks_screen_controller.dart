import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/common/utils/my_tab_controller.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';
import 'package:gps_module/features/my_tasks/controllers/map_controller.dart';
import 'package:gps_module/features/my_tasks/controllers/tasks_controller.dart';

class MyTaskaScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final MapsController _mapsController = Get.put(MapsController());

  void focusOnTask(LatLng position, TaskModel task) {
    if (Get.find<BottomNavController>().selectedIndex.value == 1) {
      Get.find<BottomNavController>().changeTabIndex(0);
    }
    tabController.animateTo(0);
    _mapsController.focusTask = task; // Focus on the specific task location
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    Get.put(TasksController());
    super.onInit();
  }
}
