
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final AuthController _authController;

  HomeController({
    required this._authController,
  });

  // Elemento seleccionado en la navegación principal
  final RxInt selectedIndex = 0.obs;

  // Cambiar sección seleccionada
  void changeSection(int index) {
    selectedIndex.value = index;
  }

  // Abrir perfil
  void openProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  // Abrir formulario de nueva inspección
  void openInspectionForm() {
    Get.toNamed(AppRoutes.inspectionForm);
  }

  // Abrir historial de inspecciones.
  void openInspectionList() {
    Get.toNamed(AppRoutes.inspections);
  }
  // Cerrar sesión
  Future<void> logout() async {
    final result = await _authController.logout();

    if (result) {
      Get.snackbar(
        'Sesión cerrada',
        'Has cerrado sesión correctamente.',
      );

      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar(
        'Error',
        _authController.errorMessage.value,
      );
    }
  }
}
