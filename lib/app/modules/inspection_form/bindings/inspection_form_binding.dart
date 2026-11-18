
import 'package:get/get.dart';

import '../../../data/providers/inspection_provider.dart';
import '../../../data/repositories/inspection_repository.dart';
import '../controllers/inspection_form_controller.dart';

class InspectionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionProvider>(
      () => InspectionProvider(),
    );

    Get.lazyPut<InspectionRepository>(
      () => InspectionRepository(
        inspectionProvider: Get.find<InspectionProvider>(),
      ),
    );

    Get.lazyPut<InspectionFormController>(
      () => InspectionFormController(
        inspectionRepository: Get.find<InspectionRepository>(),
      ),
    );
  }
}
