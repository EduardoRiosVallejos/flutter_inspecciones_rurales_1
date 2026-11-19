
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inspection_list_controller.dart';

import '../../../routes/app_routes.dart';

class InspectionListView extends GetView<InspectionListController> {
  const InspectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis inspecciones'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadInspections,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        if (controller.inspections.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No tienes inspecciones registradas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.inspections.length,
          itemBuilder: (context, index) {
            final inspection = controller.inspections[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.inspectionDetail,
                    arguments: inspection.id,
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Colors.blue.shade700,
                  ),
                ),
                title: Text(
                  inspection.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo: ${inspection.type}'),
                      const SizedBox(height: 4),
                      Text(
                        'Estado: ${_getStatusText(inspection.status)}',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fecha: ${_formatDate(inspection.createdAt)}',
                      ),
                    ],
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'open':
        return 'Abierta';
      case 'in_progress':
        return 'En progreso';
      case 'closed':
        return 'Cerrada';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    return '$day/$month/$year';
  }
}
