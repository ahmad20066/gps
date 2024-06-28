import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/custom_appbar.dart';
import 'package:gps_module/common/widgets/date_container.dart';
import 'package:gps_module/common/widgets/end_work_widget.dart';
import 'package:gps_module/common/widgets/loader.dart';
import 'package:gps_module/common/widgets/no_data.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/sales/controllers/sales_controller.dart';
import 'package:gps_module/features/sales/widgets/invoices_list.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SalesController());
    return Scaffold(
      appBar: CustomAppBar(
        text: "المبيعات",
        actions: [
          EndWorkWidget(),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
            width: double.infinity,
          ),
          DateContainer(),
          SizedBox(
            height: 20.h,
          ),
          Obx(() {
            switch (controller.salesStatus.value) {
              case RequestStatus.loading:
                return CustomLoader();
              case RequestStatus.nodata:
                return NoData();
              case RequestStatus.success:
                return invoicesList(invoices: controller.sales);
              default:
                return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
