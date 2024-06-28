import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:gps_module/common/controllers/domain_controller.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/providers/remote/interceptor.dart';

class ApiProvider {
  Dio? dio;

  init() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        baseUrl: CacheProvider.getDomain(),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          "Authorization": CacheProvider.getAppToken(),
        },
      ),
    );
    dio!.interceptors.add(
      AppInterceptors(
        dio: dio,
      ),
    );
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    String token = "",
    Map<String, dynamic>? query,
  }) async {
    // dio!.options.baseUrl = getx.Get.find<DomainController>().domain!;
    print("************");
    print(url);
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.get(url, queryParameters: query);
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    Object? body,
    String? token = "",
  }) async {
    // dio!.options.baseUrl = getx.Get.find<DomainController>().domain!;
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.baseUrl = getx.Get.find<DomainController>().domain!;
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.patch(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.baseUrl = getx.Get.find<DomainController>().domain!;
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? token = "",
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token != "" ? " Bearer $token" : "",
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: body,
    );
  }
}
