import 'package:get/get.dart';

import '../../auth/bindings/auth_binding.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();

    Get.lazyPut<HomeController>(
      () => HomeController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}