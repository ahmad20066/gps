import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/utils/custom_toasts.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/stats/stats_model.dart';
import 'package:gps_module/data/repositories/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StatisticsController extends GetxController
    with SingleGetTickerProviderMixin {
  final HomeRepository _repo = HomeRepository();
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  StatsModel? stats;

  late AnimationController animationController;
  late Animation<double> successAnimation;
  late Animation<double> failureAnimation;
  late Animation<double> pendingAnimation;
  late Animation<double> collectedAmountAnimation;
  late Animation<double> totalSalesAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    loadCachedStats();
    getStats();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void loadCachedStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedStats = prefs.getString('cachedStats');
    if (cachedStats != null) {
      stats = StatsModel.fromMap(json.decode(cachedStats));
      _initializeAnimations();
      animationController.forward();
      status(RequestStatus.success);
    }
  }

  void cacheStats(StatsModel stats) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedStats', json.encode(stats.toMap()));
  }

  void _initializeAnimations() {
    successAnimation =
        Tween<double>(begin: 0, end: stats!.total_success.toDouble())
            .animate(animationController);
    failureAnimation =
        Tween<double>(begin: 0, end: stats!.total_failed.toDouble())
            .animate(animationController);
    pendingAnimation =
        Tween<double>(begin: 0, end: stats!.total_incomplete.toDouble())
            .animate(animationController);
    collectedAmountAnimation = Tween<double>(begin: 0, end: stats!.collect_sum)
        .animate(animationController);
    totalSalesAnimation = Tween<double>(begin: 0, end: stats!.sells_sum)
        .animate(animationController);
  }

  getStats() async {
    final appResponse = await _repo.getStats();
    if (appResponse.success) {
      StatsModel newStats = StatsModel.fromMap(appResponse.data);

      if (stats == null || stats! != newStats) {
        stats = newStats;
        _initializeAnimations();
        animationController.forward(from: 0); // Restart the animation
        cacheStats(newStats);
      }

      status(RequestStatus.success);
    } else {
      if (stats == null) {
        // Only show error if there's no cached data
        status(RequestStatus.onerror);
        CustomToasts.ErrorDialog(appResponse.errorMessage!);
      }
    }
  }
}
