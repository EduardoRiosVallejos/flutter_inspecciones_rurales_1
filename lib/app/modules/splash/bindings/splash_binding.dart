
import 'package:get/get.dart';

import '../../../services/auth_service.dart';
import '../../auth/bindings/auth_binding.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();

    Get.put<SplashController>(
      SplashController(
        Get.find<AuthService>(),
      ),
    );
  }
}
