import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/router/app_routes.dart';
import 'package:gps_module/common/utils/custom_toasts.dart';

class AppInterceptors extends Interceptor {
  final Dio? dio;

  AppInterceptors({required this.dio});
  static bool isNointernet = false;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("request is sending");
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint("response is getting");
    isNointernet = false;

    if (response.statusCode == 401) {
      debugPrint("hello from 401");
      Get.snackbar("sorry".tr, "re_login".tr);
    }
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print("----------");
    print(err.message);
    print(err.response);
    if (err.message == "no_internet") {
      if (!isNointernet) {
        print("********");
        isNointernet = true;
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'no_internet'.tr,
          ),
        );
      }
      return;
    } else if (err.response?.statusCode == 401) {
      print("zzzz");
      if (Get.currentRoute != AppRoutes.login) {
        CacheProvider.clearAppToken();
        Get.offAllNamed(AppRoutes.login);
        CustomToasts.ErrorDialog(
            err.response?.statusCode.toString() ?? "relogin");
      } else {
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: err.response?.data['message'],
          ),
        );
      }
      // CustomToasts.ErrorDialog("relogin".tr);
    } else if (err.response?.statusCode == 422) {
      String? error = err.response?.data['error'] ?? "wrong_request";
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: error!.tr,
        ),
      );
    } else if (err.response?.statusCode == 403) {
      try {
        String? error = err.response?.data['error'] ?? "wrong_request";
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: error!.tr,
          ),
        );
      } catch (e) {
        print(err.message);
        return handler.next(
          DioException(
            requestOptions: err.requestOptions,
            message: 'wrong_request'.tr,
          ),
        );
      }
    } else {
      // String? error = err.response?.data['message'] ?? "wrong_request";
      if (err.response?.data == null) {
        print("********");
        if (!isNointernet) {
          isNointernet = true;
          return handler.next(
            DioException(
              requestOptions: err.requestOptions,
              message: 'no_internet'.tr,
            ),
          );
        }
        return;
      }

      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          message: "wrong_request",
        ),
      );
    }
  }
}
