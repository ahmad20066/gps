import 'package:dio/dio.dart';
import 'package:gps_module/common/constants/end_points.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/providers/remote/api_provider.dart';
import 'package:gps_module/data/enums/event_type.dart';
import 'package:gps_module/data/models/app_response.dart';
import 'package:gps_module/data/models/event/event_model.dart';
import 'package:gps_module/data/models/user/user_model.dart';

class HomeRepository {
  ApiProvider provider = ApiProvider();
  Future<AppResponse> event(EventModel event) async {
    try {
      provider.init();
      final response = await provider.post(
          url: EndPoints.event,
          body: event.toMap(),
          token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }

  Future<AppResponse> getSales() async {
    try {
      provider.init();
      final response = await provider.get(
          url: EndPoints.sales, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data['data']);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }

  Future<AppResponse> getMyTasks() async {
    try {
      provider.init();
      final response = await provider.get(
          url: EndPoints.tasks, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data['data']);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }

  Future<AppResponse> getStats() async {
    try {
      provider.init();
      final response = await provider.get(
          url: EndPoints.stats, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }
}
