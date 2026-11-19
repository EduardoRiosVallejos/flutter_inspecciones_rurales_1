
import 'package:get/get.dart';

import '../../../data/repositories/inspection_repository.dart';
import '../controllers/inspection_edit_controller.dart';

class InspectionEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionEditController>(
      () => InspectionEditController(
        inspectionRepository: Get.find<InspectionRepository>(),
      ),
    );
  }
}
