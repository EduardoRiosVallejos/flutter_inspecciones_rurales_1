
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService;

  SplashController(AuthService authService)
      : _authService = authService;

    StreamSubscription<User?>? _authSubscription;

  @override
  void onInit() {
    super.onInit();

    _authSubscription = _authService.authStateChanges.listen(
      (user) {
        if (user != null) {
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      },
    );
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
