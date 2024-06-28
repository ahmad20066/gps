import 'package:get/get.dart';
import 'package:gps_module/common/controllers/domain_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DomainController(), permanent: true);
  }
}
