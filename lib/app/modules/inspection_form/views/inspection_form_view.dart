
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inspection_form_controller.dart';

class InspectionFormView extends GetView<InspectionFormController> {
  const InspectionFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva inspección'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registrar inspección',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Completa los siguientes datos para registrar una nueva inspección.',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              _buildTextField(
                controller: controller.titleController,
                label: 'Título',
                hint: 'Ej. Inspección de camino rural',
                icon: Icons.title,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.typeController,
                label: 'Tipo de inspección',
                hint: 'Ej. Camino, infraestructura, terreno',
                icon: Icons.category,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.descriptionController,
                label: 'Descripción',
                hint: 'Describe el motivo de la inspección',
                icon: Icons.description,
                maxLines: 4,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.observationsController,
                label: 'Observaciones (opcional)',
                hint: 'Agrega observaciones adicionales',
                icon: Icons.notes,
                maxLines: 3,
                required: false,
              ),

              const SizedBox(height: 30),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          debugPrint('BOTON: presionado');

                          final saved = await controller.saveInspection();

                          debugPrint('RESULTADO DEL GUARDADO: $saved');

                          if (saved) {
                            debugPrint('NAVEGACION: regresando a Home');

                            Get.back();

                            Get.snackbar(
                              'Inspección registrada',
                              'La inspección se registró correctamente.',
                              duration: const Duration(seconds: 4),
                            );
                          } else {
                            debugPrint(
                              'NAVEGACION: no se ejecuto porque saved es false',
                            );
                          }
                        },
                    icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      controller.isLoading.value
                          ? 'Guardando...'
                          : 'Guardar inspección',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (required && (value == null || value.trim().isEmpty)) {
          return 'Este campo es obligatorio.';
        }

        return null;
      },
    );
  }
}
