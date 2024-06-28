import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/common/widgets/custom_textfield.dart';
import 'package:gps_module/data/enums/request_status.dart';
import 'package:gps_module/features/login/controllers/login_controller.dart';

class LoginSheet extends GetWidget<LoginController> {
  const LoginSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormkey,
      child: Column(
        children: [
          Text(
            "يرجى تسجيل الدخول",
            style: TextStyle(color: Colors.black, fontSize: 22.sp),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: controller.nameController,
            hint: "اسم المستخدم",
            validator: (v) {
              if (v!.isEmpty) {
                return "يرجى ادخال اسم المستخدم";
              }
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            controller: controller.passwordController,
            hint: "كلمة المرور",
            validator: (v) {
              if (v!.isEmpty) {
                return "يرجى ادخال كلمة المرور";
              }
            },
            action: TextInputAction.done,
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx(() => controller.status.value == RequestStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  height: 50.h,
                  width: 319.w,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (controller.loginFormkey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  text: "تسجيل الدخول"))
        ],
      ),
    );
  }
}
