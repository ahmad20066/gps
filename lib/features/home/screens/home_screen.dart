import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_module/features/home/controllers/bottom_nav_controller.dart';
import 'package:gps_module/features/home/widgets/bottom_navbar.dart';
import 'package:gps_module/features/my_tasks/pages/my_tasks_screen.dart';
import 'package:gps_module/features/sales/pages/sales_page.dart';
import 'package:gps_module/features/statistics/pages/statistics_page.dart';

class HomeScreen extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Obx(() => bottomNavController.pages
            .elementAt(bottomNavController.selectedIndex.value)),
        bottomNavigationBar: CustomBottomNavigationBar());
  }
}
