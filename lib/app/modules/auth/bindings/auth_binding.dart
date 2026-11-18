
import 'package:get/get.dart';

import '../../../data/providers/auth_provider.dart' as app_auth;
import '../../../data/providers/user_provider.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../services/auth_service.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // AuthProvider
    Get.lazyPut<app_auth.AuthProvider>(
      () => app_auth.AuthProvider(),
    );

    // AuthRepository
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        authProvider: Get.find<app_auth.AuthProvider>(),
      ),
    );

    // AuthService
    Get.lazyPut<AuthService>(
      () => AuthService(
        authRepository: Get.find<AuthRepository>(),
      ),
    );

    // UserProvider
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );

    // UserRepository
    Get.lazyPut<UserRepository>(
      () => UserRepository(
        Get.find<UserProvider>(),
      ),
    );

    // AuthController
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );
  }
}
