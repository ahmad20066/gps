import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/utils/custom_toasts.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/data/repositories/home_repository.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'map_controller.dart';

class TasksController extends GetxController {
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> originalTasks = <TaskModel>[].obs;
  TextEditingController searchController = TextEditingController();
  final HomeRepository _repo = HomeRepository();
  Rx<RequestStatus> tasksStatus = RequestStatus.begin.obs;

  @override
  void onInit() {
    super.onInit();
    CacheProvider.init().then((_) => loadCachedTasks());
  }

  Future<BitmapDescriptor> getMarkerIcon(String tag) async {
    print(tag);
    BitmapDescriptor markerIcon;
    switch (tag) {
      case "Normal":
        markerIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        break;
      case "VIP":
        markerIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        break;
      case 'Low':
        markerIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
        break;
      default:
        markerIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
    return markerIcon;
  }

  void loadCachedTasks() async {
    String? cachedDate = CacheProvider.getCachedDate();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (cachedDate == currentDate) {
      List<dynamic>? cachedTasks = CacheProvider.getCachedTasks();
      if (cachedTasks != null) {
        tasks.value = cachedTasks.map((e) => TaskModel.fromMap(e)).toList();
        originalTasks.value = List<TaskModel>.from(tasks);
        tasksStatus(RequestStatus.success);
        _addMarkers(tasks);
        return;
      }
    }
    getTasks();
  }

  getTasks() async {
    tasksStatus(RequestStatus.loading);
    final appResponse = await _repo.getMyTasks();
    if (appResponse.success) {
      tasks.value =
          (appResponse.data as List).map((e) => TaskModel.fromMap(e)).toList();
      originalTasks.value = List<TaskModel>.from(tasks);
      CacheProvider.cacheTasks(
          appResponse.data, DateFormat('yyyy-MM-dd').format(DateTime.now()));
      if (tasks.isEmpty) {
        tasksStatus(RequestStatus.nodata);
      } else {
        tasksStatus(RequestStatus.success);
        _addMarkers(tasks);
      }
    } else {
      tasksStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }

  Future<void> _addMarkers(List<TaskModel> tasks) async {
    final markers = await Future.wait(tasks.map((e) async {
      final markerIcon = await getMarkerIcon(e.tag);
      return Marker(
        markerId: MarkerId(e.customer_name),
        position: LatLng(e.latitude, e.longitude),
        icon: markerIcon,
        onTap: () {
          Get.find<MapsController>()
              .onMarkerTapped(LatLng(e.latitude, e.longitude), e);
        },
      );
    }));
    Get.find<MapsController>().markers.addAll(markers);
  }

  search() {
    if (searchController.text.trim().isEmpty) {
      tasks.value = List<TaskModel>.from(originalTasks);
      return;
    }
    tasks.value = originalTasks
        .where((element) =>
            element.customer_name.contains(searchController.text) ||
            element.customer_number.contains(searchController.text))
        .toList();
  }
}
