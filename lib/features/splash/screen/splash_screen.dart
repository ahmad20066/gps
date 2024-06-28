import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/constants/app_colors.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/router/app_routes.dart';
import 'package:gps_module/common/widgets/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double scale = 1;
  double opacity = 1;
  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 1)).then((v) {
      setState(() {
        scale = 0.5;
      });

      Future.delayed(Duration(milliseconds: 500)).then((value) => setState(() {
            opacity = 0;
            scale = 5;
            Future.delayed(Duration(milliseconds: 500)).then((value) {
              if (CacheProvider.getAppToken() != null) {
                Get.offAllNamed(AppRoutes.home);
              } else {
                Get.offAllNamed(
                  AppRoutes.login,
                );
              }
            });
          }));
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          BackGroundImage(
            color: Colors.white,
          ),
          Center(
            child: Container(
              height: 220.h,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3)),
            ),
          ),
          Center(
            child: AnimatedScale(
              duration: Duration(milliseconds: 500),
              scale: scale,
              child: CircleAvatar(
                radius: 100.r,
                backgroundColor: Colors.white,
                child: SizedBox.shrink(),
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: opacity,
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.contain,
                // color: AppColors.primaryColor,
              ),
            ),
          )
          // Center(
          //   child: Container(
          //     // padding: EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.transparent,
          //         border: Border.all(color: Colors.white, width: 3)),
          //     child: AnimatedContainer(
          //       duration: Duration(seconds: 1),
          //       height: scale,
          //       width: scale,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child: Image.asset("assets/images/splash.png"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
