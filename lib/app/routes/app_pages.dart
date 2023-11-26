
import 'package:get/get.dart';
import '../ui/intro/intro_screen.dart';
part './app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(name: Routes.splashPage, page:()=> SplashPage(),),
    GetPage(name: Routes.introScreen, page:()=> IntroScreen(),),
  ];
}