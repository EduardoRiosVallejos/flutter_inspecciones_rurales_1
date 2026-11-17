
import 'package:get/get.dart';

import '../../../data/providers/auth_provider.dart' as app_auth;
import '../../../data/repositories/auth_repository.dart';
import '../../../services/auth_service.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar AuthProvider
    Get.lazyPut<app_auth.AuthProvider>(
      () => app_auth.AuthProvider(),
    );

    // Registrar AuthRepository
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        authProvider: Get.find<app_auth.AuthProvider>(),
      ),
    );

    // Registrar AuthService
    Get.lazyPut<AuthService>(
      () => AuthService(
        authRepository: Get.find<AuthRepository>(),
      ),
    );

    // Registrar AuthController
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
      ),
    );
  }
}
