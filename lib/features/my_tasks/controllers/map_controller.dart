import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/features/my_tasks/widgets/custom_info_window_widget.dart';

class MapsController extends GetxController {
  late GoogleMapController mapController;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  RxBool isMapReady = false.obs;
  Rx<LatLng> initialPosition =
      LatLng(48.8584, 2.2945).obs; // Initial map center (San Francisco)
  TaskModel? focusTask;
  RxList<Marker> markers = <Marker>[].obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    customInfoWindowController.googleMapController = controller;
    if (focusTask != null) {
      print(focusTask!.latitude);
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(focusTask!.latitude, focusTask!.longitude), 15));
      customInfoWindowController.addInfoWindow!(
        CustomInfoWindowContent(task: focusTask!),
        LatLng(focusTask!.latitude, focusTask!.longitude),
      );
      focusTask = null;
    }

    isMapReady(true);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void onMarkerTapped(LatLng position, TaskModel task) {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    customInfoWindowController.addInfoWindow!(
      CustomInfoWindowContent(
        task: task,
      ),
      position,
    );
  }

  void focusOnTask(TaskModel task) {
    isMapReady.listen((isReady) {
      print("222222222222");
      if (isReady) {
        print("-------------");
        LatLng position = LatLng(task.latitude, task.longitude);
        mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
        customInfoWindowController.addInfoWindow!(
          CustomInfoWindowContent(
            task: task,
          ),
          position,
        );
      }
    });
  }

  @override
  Future<void> onInit() async {
    final Position position = await _determinePosition();
    initialPosition.value = LatLng(position.latitude, position.longitude);
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(initialPosition.value, 30));
    super.onInit();
  }

  @override
  void onClose() {
    customInfoWindowController.dispose();
    super.onClose();
  }
}
