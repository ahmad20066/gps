import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/common/widgets/custom_textfield.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/login/controllers/login_controller.dart';

class DomainSheet extends GetWidget<LoginController> {
  const DomainSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.domainFormkey,
      child: Column(
        children: [
          Text(
            "أدخل الدومين",
            style: TextStyle(color: Colors.black, fontSize: 22.sp),
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomTextField(
            controller: controller.domainController,
            hint: "الدومين",
            validator: (v) {
              if (v!.isEmpty) {
                return "الرجاء ادخال دومين";
              }
              print(!v.contains("https://"));
              print(!v.contains("http://"));
              if (!v.contains("https://") && !v.contains("http://")) {
                return "الرجاء ادخال دومين صالح";
              }
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => controller.domainStatus.value == RequestStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  height: 50.h,
                  width: 329,
                  onTap: () async {
                    if (controller.domainFormkey.currentState!.validate()) {
                      await controller.applyDomain();
                      controller.checkDomain();
                    }
                  },
                  text: "التالي")),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
