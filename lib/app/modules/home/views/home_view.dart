
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspecciones Rurales'),
        actions: [
          IconButton(
            onPressed: controller.openProfile,
            icon: const Icon(Icons.person),
            tooltip: 'Mi perfil',
          ),
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Panel principal de Inspecciones Rurales',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Resumen de jornada',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.fact_check,
                    title: 'Inspecciones',
                    value: '0',
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.cloud_upload,
                    title: 'Pendientes',
                    value: '0',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Accesos principales',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildMenuCard(
              icon: Icons.add_location_alt,
              title: 'Inspecciones',
              subtitle: 'Registrar una nueva inspección',
              onTap: controller.openInspectionForm,
            ),

            _buildMenuCard(
              icon: Icons.history,
              title: 'Historial',
              subtitle: 'Consultar inspecciones anteriores',
              onTap: () {
                Get.snackbar(
                  'Historial',
                  'Este módulo se implementará en la Fase 12.',
                );
              },
            ),

            _buildMenuCard(
              icon: Icons.person_outline,
              title: 'Mi perfil',
              subtitle: 'Consultar y actualizar tus datos',
              onTap: controller.openProfile,
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.cloud_done_outlined,
                  color: Colors.green,
                ),
                title: const Text('Estado de conectividad'),
                subtitle: const Text(
                  'Indicador de conectividad pendiente de implementar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 35,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Colors.green,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
