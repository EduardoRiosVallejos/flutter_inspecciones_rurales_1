
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inspection_detail_controller.dart';

class InspectionDetailView
    extends GetView<InspectionDetailController> {
  const InspectionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de inspección'),
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
            child: Text(controller.errorMessage.value),
          );
        }

        final inspection = controller.inspection.value;

        if (inspection == null) {
          return const Center(
            child: Text('No se encontró la inspección.'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inspection.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfo('Tipo', inspection.type),
              _buildInfo('Descripción', inspection.description),
              _buildInfo('Observaciones', inspection.observations),
              _buildInfo('Estado', inspection.status),
              _buildInfo(
                'Fecha de creación',
                _formatDate(inspection.createdAt),
              ),
              _buildInfo(
                'Última actualización',
                _formatDate(inspection.updatedAt),
              ),
              if (inspection.latitude != null)
                _buildInfo(
                  'Latitud',
                  inspection.latitude.toString(),
                ),
              if (inspection.longitude != null)
                _buildInfo(
                  'Longitud',
                  inspection.longitude.toString(),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value.isEmpty ? 'Sin información' : value,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }
}
