
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/inspection_model.dart';
import '../../../data/repositories/inspection_repository.dart';

class InspectionEditController extends GetxController {
  final InspectionRepository inspectionRepository;

  InspectionEditController({
    required this.inspectionRepository,
  });

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final observationsController = TextEditingController();

  final RxBool isLoading = false.obs;

  late InspectionModel originalInspection;

  @override
  void onInit() {
    super.onInit();

    originalInspection = Get.arguments as InspectionModel;

    titleController.text = originalInspection.title;
    typeController.text = originalInspection.type;
    descriptionController.text = originalInspection.description;
    observationsController.text = originalInspection.observations;
  }

  Future<bool> updateInspection() async {
    if (isLoading.value) return false;

    if (formKey.currentState == null ||
        !formKey.currentState!.validate()) {
      return false;
    }

    try {
      isLoading.value = true;

      final updatedInspection = originalInspection.copyWith(
        title: titleController.text.trim(),
        type: typeController.text.trim(),
        description: descriptionController.text.trim(),
        observations: observationsController.text.trim(),
        updatedAt: DateTime.now(),
      );

      inspectionRepository.updateInspection(updatedInspection);

      return true;
    } catch (error) {
      debugPrint('ERROR AL ACTUALIZAR INSPECCIÓN: $error');

      Get.snackbar(
        'Error',
        'No se pudo actualizar la inspección.',
      );

      return false;
    } finally {
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
