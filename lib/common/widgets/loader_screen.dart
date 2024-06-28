import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  double size = 30;
  String? nextRoute;
  bool isExpanding = true;
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (timer.tick == 4) {
        setState(() {
          size = MediaQuery.of(context).size.height;
        });
        timer.cancel();
        Timer(Duration(milliseconds: 300), () {
          //the argument is the nextRoute
          Get.offAllNamed(Get.arguments);
        });
      } else {
        Timer(Duration(milliseconds: 300), () {
          setState(() {
            isExpanding = true;
            size += 120;
          });
          Timer(Duration(milliseconds: 300), () {
            setState(() {
              isExpanding = false;
              size -= 30;
            });
          });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedContainer(
            height: size,
            width: size,
            color: size >= 400 ? AppColors.primaryColor : Colors.transparent,
            duration: Duration(milliseconds: isExpanding ? 300 : 100),
            child: Image.asset(
              "assets/images/loader.png",
              color: AppColors.primaryColor,
              // height: size - 20,
              // width: size - 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
