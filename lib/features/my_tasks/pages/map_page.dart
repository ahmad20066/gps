import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/features/my_tasks/controllers/map_controller.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});
  final controller = Get.put(MapsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.initialPosition.value,
                  zoom: 10.0,
                ),
                markers: Set.from(controller.markers),
                onTap: (position) {
                  controller.customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  controller.customInfoWindowController.onCameraMove!();
                },
              )),
          CustomInfoWindow(
            controller: controller.customInfoWindowController,
            height: 170.h,
            width: 190.w,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
