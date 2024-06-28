import 'package:get/get.dart';
import 'package:gps_module/common/widgets/loader_screen.dart';
import 'package:gps_module/features/home/screens/home_screen.dart';
import 'package:gps_module/features/login/screen/login_screen.dart';
import 'package:gps_module/features/my_tasks/pages/visit_webview_page.dart';

class AppRoutes {
  static const splash = "/splash";
  static const login = "/login";
  static const home = "/home";
  static const loading = "/loading";
  static const visitWebview = "/visit_webview";

  static List<GetPage> pages = [
    GetPage(
        name: login,
        page: () => LogInScreen(),
        transitionDuration: Duration(seconds: 1),
        transition: Transition.upToDown),
    GetPage(
      name: loading,
      page: () => LoaderScreen(),
    ),
    GetPage(
      name: home,
      transition: Transition.fade,
      transitionDuration: Duration(seconds: 1),
      page: () => HomeScreen(),
    ),
    GetPage(
      name: visitWebview,
      page: () => VisitWebViewPage(),
    ),
  ];
}
