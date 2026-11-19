
import 'package:get/get.dart';

import '../../../data/repositories/inspection_repository.dart';
import '../controllers/inspection_detail_controller.dart';

class InspectionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionDetailController>(
      () => InspectionDetailController(
        inspectionRepository: Get.find<InspectionRepository>(),
      ),
    );
  }
}
