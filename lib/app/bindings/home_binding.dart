import 'package:get/get.dart';

import '../ui/splash/splash_conroller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
     }
}
