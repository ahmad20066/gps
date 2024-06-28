import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/widgets/custom_button.dart';
import 'package:gps_module/common/widgets/custom_row.dart';
import 'package:gps_module/data/models/invoice/invoice_model.dart';
import 'package:gps_module/data/models/sales/sales_model.dart';

class InvoiceWidget extends StatelessWidget {
  final SalesModel invoice;
  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      // width: 326.w,
      margin: REdgeInsets.symmetric(horizontal: 32.w),
      height: 182.h,
      decoration: BoxDecoration(
        color: Color.fromRGBO(243, 243, 243, 1),
        // color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomRow(
                        value: invoice.contact.name, icon: Icons.face_outlined),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomRow(
                        value: invoice.contact.mobile,
                        icon: Icons.phone_outlined),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomRow(
                        value: invoice.final_total,
                        icon: Icons.local_atm_outlined),
                  ],
                ),
              ),
              Spacer(),
              Text(
                invoice.type,
                style:
                    TextStyle(color: AppColors.primaryColor, fontSize: 24.sp),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomButton(
            onTap: () {},
            text: "تعديل الفاتورة",
            prefix: Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
