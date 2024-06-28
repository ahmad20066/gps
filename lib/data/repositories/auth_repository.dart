import 'package:dio/dio.dart';
import 'package:gps_module/common/constants/end_points.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/providers/remote/api_provider.dart';
import 'package:gps_module/data/models/app_response.dart';
import 'package:gps_module/data/models/user/user_model.dart';

class AuthRepository {
  ApiProvider provider = ApiProvider();

  Future<AppResponse> login(UserModel user) async {
    try {
      provider.init();
      print(user.toLogin());
      final response =
          await provider.post(url: EndPoints.login, body: user.toLogin());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }

  Future<AppResponse> logout() async {
    try {
      provider.init();
      final response = await provider.post(
          url: EndPoints.logout, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }

  Future<AppResponse> checkDomain() async {
    try {
      provider.init();
      final response = await provider.get(url: EndPoints.checkDomain);
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(success: false, errorMessage: e.message);
    }
  }
}
