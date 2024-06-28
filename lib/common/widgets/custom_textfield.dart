import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String>? validator;
  final TextInputAction? action;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.action = TextInputAction.next,
      this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? validateText;
  bool showToast = false;
  @override
  Widget build(BuildContext context) {
    print(validateText);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: SizedBox(
        height: 90.h,
        child: Stack(
          children: [
            TextFormField(
              textInputAction: widget.action,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              validator: widget.validator == null
                  ? null
                  : (v) {
                      setState(() {
                        validateText = widget.validator!(v);
                      });
                      if (validateText != null) {
                        return "";
                      }
                    },
              onChanged: (v) {
                setState(() {
                  showToast = false;
                });
              },
              decoration: InputDecoration(
                contentPadding:
                    REdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                filled: true,
                suffixIcon: validateText != null
                    ? IconButton(
                        icon: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            showToast = !showToast;
                          });
                        },
                      )
                    : null,
                fillColor: Colors.white,
                hintText: widget.hint,
                hintStyle: TextStyle(color: AppColors.greyTextColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            if (showToast)
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: REdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    validateText!,
                    style: TextStyle(color: Color.fromRGBO(253, 253, 245, 1)),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
