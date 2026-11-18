
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class HomeView extends GetView<AuthController> {
  const HomeView({super.key});

  Future<void> _logout() async {
    final result = await controller.logout();

    if (result) {
      Get.snackbar(
        'Sesión cerrada',
        'Has cerrado sesión correctamente.',
      );

      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar(
        'Error',
        controller.errorMessage.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspecciones Rurales'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.profile);
            },
            icon: const Icon(Icons.person),
            tooltip: 'Mi perfil',
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fact_check_outlined,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Pantalla provisional de inicio'),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.profile);
              },
              icon: const Icon(Icons.person),
              label: const Text('Mi perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
