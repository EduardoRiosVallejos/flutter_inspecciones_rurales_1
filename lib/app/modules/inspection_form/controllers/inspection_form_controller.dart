
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/inspection_model.dart';
import '../../../data/repositories/inspection_repository.dart';

class InspectionFormController extends GetxController {
  final InspectionRepository _inspectionRepository;

  InspectionFormController({
    required this._inspectionRepository,
  });

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final observationsController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<bool> saveInspection() async {

        debugPrint('INICIO: saveInspection ejecutado');
        // Evitar varios registros por clics repetidos.
    if (isLoading.value) {
      debugPrint('BLOQUEADO: ya existe un guardado en curso');
      return false;
    }

    if (formKey.currentState == null ||
        !formKey.currentState!.validate()) {
      return false;
    }

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Get.snackbar(
        'Sesión no disponible',
        'Debes iniciar sesión para registrar una inspección.',
      );
      return false;
    }

    try {
      isLoading.value = true;

      final now = DateTime.now();
      final inspectionId =
          _inspectionRepository.generateInspectionId();

      final inspection = InspectionModel(
        id: inspectionId,
        userId: currentUser.uid,
        title: titleController.text.trim(),
        type: typeController.text.trim(),
        description: descriptionController.text.trim(),
        observations: observationsController.text.trim(),
        status: 'open',
        createdAt: now,
        updatedAt: now,
      );

      debugPrint('GUARDANDO: ${inspection.id}');

      debugPrint('SOLICITUD DE GUARDADO INICIADA');
      // Firestore conserva la escritura local y gestiona
      // su sincronización cuando vuelve Internet.
      _inspectionRepository.createInspection(inspection);

      debugPrint('SOLICITUD DE GUARDADO ENVIADA');

      return true;
    } catch (e) {
      debugPrint('Error al registrar inspección: $e');

      Get.snackbar(
        'Error',
        'No se pudo iniciar el registro de la inspección.',
      );

      return false;
    } finally {
      debugPrint('FINALIZANDO: se desactiva la carga');
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    typeController.dispose();
    descriptionController.dispose();
    observationsController.dispose();

    super.onClose();
  }
}
