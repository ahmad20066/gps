import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/controllers/domain_controller.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/router/app_routes.dart';
import 'package:gps_module/common/utils/custom_toasts.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/app_response.dart';
import 'package:gps_module/data/models/user/user_model.dart';
import 'package:gps_module/data/repositories/auth_repository.dart';
import 'package:gps_module/features/login/widgets/domain_sheet.dart';
import 'package:gps_module/features/login/widgets/login_sheet.dart';

class LoginController extends GetxController {
  RxDouble height = 360.h.obs;
  Rx<ValueNotifier<Widget>> child = Rx(ValueNotifier(DomainSheet()));
  /////
  TextEditingController domainController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  GlobalKey<FormState> domainFormkey = GlobalKey<FormState>();
  //////
  final AuthRepository _repo = AuthRepository();
  Rx<RequestStatus> status = RequestStatus.begin.obs;
  Rx<RequestStatus> domainStatus = RequestStatus.begin.obs;
  switchtoLogin() {
    height.value = 445.h;
    child.value.value = LoginSheet();
  }

  login() async {
    status(RequestStatus.loading);
    final user = UserModel(
        username: nameController.text, password: passwordController.text);
    final AppResponse appResponse = await _repo.login(user);
    if (appResponse.success) {
      await CacheProvider.setAppToken(appResponse.data['token']);

      status(RequestStatus.success);
      Get.offAllNamed(AppRoutes.loading, arguments: AppRoutes.home);
    } else {
      status(RequestStatus.onerror);
      print(status);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
    // Get.offAllNamed(AppRoutes.loading, arguments: AppRoutes.home);
  }

  applyDomain() {
    Get.find<DomainController>().domain = domainController.text;
    CacheProvider.saveDomain(domainController.text);
  }

  checkDomain() async {
    domainStatus(RequestStatus.loading);
    final AppResponse appResponse = await _repo.checkDomain();
    if (appResponse.success) {
      domainStatus(RequestStatus.success);
      switchtoLogin();
    } else {
      domainStatus(RequestStatus.onerror);
      CustomToasts.ErrorDialog(appResponse.errorMessage!);
    }
  }

  @override
  void onInit() {
    if (CacheProvider.getDomain() != null) {
      domainController.text = CacheProvider.getDomain();
    }
    super.onInit();
  }
}
