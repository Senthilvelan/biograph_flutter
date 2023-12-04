import 'package:get/get.dart';
import '../ui/intro/intro_screen.dart';
import '../ui/login/login_page.dart';
import '../ui/splash/splash_page.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splashPage,
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.introScreen,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginPage(),
    ),
  ];
}
