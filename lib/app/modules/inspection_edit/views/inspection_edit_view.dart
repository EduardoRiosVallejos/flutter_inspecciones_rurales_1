
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inspection_edit_controller.dart';

class InspectionEditView extends GetView<InspectionEditController> {
  const InspectionEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar inspección'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Modificar inspección',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Modifica los datos de la inspección seleccionada.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),

              _buildTextField(
                controller: controller.titleController,
                label: 'Título',
                hint: 'Título de la inspección',
                icon: Icons.title,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.typeController,
                label: 'Tipo de inspección',
                hint: 'Tipo de inspección',
                icon: Icons.category,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.descriptionController,
                label: 'Descripción',
                hint: 'Describe la inspección',
                icon: Icons.description,
                maxLines: 4,
              ),

              const SizedBox(height: 18),

              _buildTextField(
                controller: controller.observationsController,
                label: 'Observaciones (opcional)',
                hint: 'Observaciones adicionales',
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
                            final updated =
                                await controller.updateInspection();

                            if (updated) {
                              Get.back(result: true);

                              Get.snackbar(
                                'Inspección actualizada',
                                'Los cambios se guardaron correctamente.',
                                duration: const Duration(seconds: 4),
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
                          ? 'Actualizando...'
                          : 'Guardar cambios',
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
