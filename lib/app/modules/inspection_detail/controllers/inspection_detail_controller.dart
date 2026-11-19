
import 'package:get/get.dart';

import '../../../data/models/inspection_model.dart';
import '../../../data/repositories/inspection_repository.dart';

class InspectionDetailController extends GetxController {
  final InspectionRepository inspectionRepository;

  InspectionDetailController({
    required this.inspectionRepository,
  });

  final Rxn<InspectionModel> inspection = Rxn<InspectionModel>();
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInspection();
  }

  Future<void> loadInspection() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final inspectionId = Get.arguments as String;

      final result =
          await inspectionRepository.getInspection(inspectionId);

      if (result == null) {
        errorMessage.value = 'No se encontró la inspección.';
        return;
      }

      inspection.value = result;
    } catch (error) {
      errorMessage.value =
          'No fue posible cargar la inspección.';
    } finally {
      isLoading.value = false;
    }
  }
}
