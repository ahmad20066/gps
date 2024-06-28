import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_module/common/controllers/main_binding.dart';
import 'package:gps_module/common/providers/local/cache_provider.dart';
import 'package:gps_module/common/router/app_routes.dart';
import 'package:gps_module/common/theme/app_theme.dart';
import 'package:gps_module/features/home/screens/home_screen.dart';
import 'package:gps_module/features/splash/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheProvider.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(),
        home: SplashScreen(),
        textDirection: TextDirection.rtl,
        getPages: AppRoutes.pages,
        initialBinding: MainBinding(),
      ),
    );
  }
}
