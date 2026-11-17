
import 'package:get/get.dart';

import '../modules/initial/initial_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';

import 'app_routes.dart';

class AppPages {
  // Ruta inicial de la aplicación
  static const initial = AppRoutes.initial;

  // Rutas disponibles
  static final routes = <GetPage>[
    // Pantalla inicial
    GetPage(
      name: AppRoutes.initial,
      page: () => const InitialView(),
    ),

    // Inicio de sesión
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),

    // Registro de usuarios
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
  ];
}
