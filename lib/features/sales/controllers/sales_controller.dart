import 'package:get/get.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/data/models/invoice/invoice_model.dart';
import 'package:gps_module/data/models/sales/sales_model.dart';
import 'package:gps_module/data/repositories/home_repository.dart';

class SalesController extends GetxController {
  List<SalesModel> sales = [];
  final HomeRepository _repo = HomeRepository();
  Rx<RequestStatus> salesStatus = RequestStatus.begin.obs;
  getSales() async {
    salesStatus(RequestStatus.loading);
    final appresponse = await _repo.getSales();
    if (appresponse.success) {
      sales =
          (appresponse.data as List).map((e) => SalesModel.fromMap(e)).toList();
      if (sales.isEmpty) {
        salesStatus(RequestStatus.nodata);
      } else {
        salesStatus(RequestStatus.success);
      }
    } else {
      salesStatus(RequestStatus.onerror);
    }
  }

  @override
  void onInit() {
    getSales();
    super.onInit();
  }
}
