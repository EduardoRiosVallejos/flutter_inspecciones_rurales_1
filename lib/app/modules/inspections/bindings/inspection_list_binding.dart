
import 'package:get/get.dart';

import '../../../data/providers/inspection_provider.dart';
import '../../../data/repositories/inspection_repository.dart';
import '../controllers/inspection_list_controller.dart';

class InspectionListBinding extends Bindings {
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

    Get.lazyPut<InspectionListController>(
      () => InspectionListController(
        inspectionRepository: Get.find<InspectionRepository>(),
      ),
    );
  }
}
