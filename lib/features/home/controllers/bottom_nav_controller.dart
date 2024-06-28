import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/router/app_routes.dart';
import 'package:gps_module/common/utils/custom_toasts.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/data/enums/event_type.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/event/event_model.dart';
import 'package:gps_module/data/models/task/task_model.dart';
import 'package:gps_module/data/repositories/auth_repository.dart';
import 'package:gps_module/data/repositories/home_repository.dart';
import 'package:gps_module/features/home/screens/end_shift_page.dart';
import 'package:gps_module/features/home/screens/start_shift_page.dart';
import 'package:gps_module/features/my_tasks/pages/my_tasks_screen.dart';
import 'package:gps_module/features/sales/pages/sales_page.dart';
import 'package:gps_module/features/statistics/pages/statistics_page.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  List<Map<String, dynamic>> labels = [
    {"title": "مهامي", "icon": Icons.local_shipping_outlined},
    {"title": "الاحصائيات", "icon": Icons.donut_small_outlined},
    {"title": "المبيعات", "icon": Icons.account_balance_wallet_outlined},
  ];
  RxBool isWorking = false.obs;
  Widget? oldPage;
  RxList<Widget> pages = <Widget>[
    MyTasksScreen(),
    Statisticspage(),
    SalesPage(),
  ].obs;
  final HomeRepository _repo = HomeRepository();
  final AuthRepository _authRepo = AuthRepository();
  Rx<RequestStatus> startStatus = RequestStatus.begin.obs;
  Rx<RequestStatus> startVisitStatus = RequestStatus.begin.obs;
  Rx<RequestStatus> endVisitStatus = RequestStatus.begin.obs;
  Rx<RequestStatus> endStatus = RequestStatus.begin.obs;
  Rx<RequestStatus> logoutStatus = RequestStatus.begin.obs;

  void changeTabIndex(int index) {
    if (index == 0) {
      checkStopWorking();
    }
    selectedIndex.value = index;
  }

  showEndConfirm() {
    oldPage = pages[selectedIndex.value];
    pages[selectedIndex.value] = EndShiftPage();
  }

  showEndVisitConfirm() {
    Get.dialog(AlertDialog(
      title: Text("انهاء الزيارة"),
      content: Text("هل انت متأكد انك تريد إنهاء الزيارة؟"),
      actions: [
        TextButton(
            onPressed: () async {
              Get.back();
              await endVisit();
            },
            child: Text("نعم")),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("لا")),
      ],
    ));
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  startVisit(TaskModel task) async {
    try {
      task.loading!(true);
      final position = await _determinePosition();
      // final distance = _calculateDistance(
      //     latitude, longitude, position.latitude, position.longitude);
      final distance =
          _calculateDistance(34.052235, -118.243683, 34.051000, -118.245000);
      print(distance);
      if (distance > 50) {
        CustomToasts.ErrorDialog(
            "لا يمكنك بدء الزيارة حاليا يجب ان تكون ضمن نطاق الزبون");
        task.loading!(false);
        return;
      }

      print(position);
      final eventModel = EventModel(
          type: EventType.startVisit,
          longitude: position.longitude,
          latitude: position.latitude);
      final appResponse = await _repo.event(eventModel);
      if (appResponse.success) {
        task.loading!(false);
        Get.toNamed(AppRoutes.visitWebview,
            arguments: appResponse.data['data']['redirect']);
      } else {
        task.loading!(false);
        CustomToasts.ErrorDialog(appResponse.errorMessage!);
      }
    } catch (e) {
      task.loading!(false);
      CustomToasts.ErrorDialog(e.toString());
    }
  }

  endWork() async {
    try {
      endStatus(RequestStatus.loading);
      final position = await _determinePosition();
      final eventModel = EventModel(
          type: EventType.endShift,
          longitude: position.longitude,
          latitude: position.latitude);
      final appResponse = await _repo.event(eventModel);
      if (appResponse.success) {
        isWorking.value = false;
        CacheProvider.saveIsWorking(false);
        pages[selectedIndex.value] = oldPage!;
        endStatus(RequestStatus.success);
      } else {
        endStatus(RequestStatus.onerror);
      }
    } catch (e) {
      endStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(e.toString());
    }
  }

  endVisit() async {
    try {
      endVisitStatus(RequestStatus.loading);
      final position = await _determinePosition();
      final eventModel = EventModel(
          type: EventType.endVisit,
          longitude: position.longitude,
          latitude: position.latitude);
      final appResponse = await _repo.event(eventModel);
      if (appResponse.success) {
        endVisitStatus(RequestStatus.success);
        Get.back();
      } else {
        endVisitStatus(RequestStatus.onerror);
      }
    } catch (e) {
      endVisitStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(e.toString());
    }
  }

  startWork() async {
    try {
      startStatus(RequestStatus.loading);
      final position = await _determinePosition();
      final eventModel = EventModel(
          type: EventType.startShift,
          longitude: position.longitude,
          latitude: position.latitude);
      final appResponse = await _repo.event(eventModel);
      if (appResponse.success) {
        isWorking(true);
        CacheProvider.saveIsWorking(true);
        checkStopWorking();
        startStatus(RequestStatus.success);
      } else {
        startStatus(RequestStatus.onerror);
      }
    } catch (e) {
      startStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(e.toString());
    }
  }

  cancelEndWork() {
    pages[selectedIndex.value] = oldPage!;
    oldPage = null;
  }

  checkStopWorking() {
    if (isWorking.isTrue) {
      pages.value = [
        MyTasksScreen(),
        Statisticspage(),
        SalesPage(),
      ];
    } else {
      pages.value = [
        StartShiftPage(),
        Statisticspage(),
        SalesPage(),
      ];
    }
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

  logout() async {
    logoutStatus(RequestStatus.loading);
    final appResponse = await _authRepo.logout();
    if (appResponse.success) {
      logoutStatus(RequestStatus.success);
      CacheProvider.clearAppToken();
      Get.offAllNamed(AppRoutes.login);
    } else {
      logoutStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }

  @override
  void onInit() {
    if (CacheProvider.getIsWorking() == null) {
      CacheProvider.saveIsWorking(false);
    } else {
      isWorking.value = CacheProvider.getIsWorking();
    }
    checkStopWorking();
    super.onInit();
  }
}
