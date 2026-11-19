
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/inspection_model.dart';
import '../../../data/repositories/inspection_repository.dart';

class InspectionListController extends GetxController {
  final InspectionRepository inspectionRepository;

  InspectionListController({
    required this.inspectionRepository,
  });

  // Lista reactiva de inspecciones.
  final RxList<InspectionModel> inspections =
      <InspectionModel>[].obs;

  // Estado de carga.
  final RxBool isLoading = true.obs;

  // Mensaje de error.
  final RxString errorMessage = ''.obs;

  StreamSubscription<List<InspectionModel>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    loadInspections();
  }

  // Escuchar las inspecciones del usuario autenticado.
  void loadInspections() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      errorMessage.value =
          'No hay una sesión de usuario activa.';
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    _subscription?.cancel();

    _subscription = inspectionRepository
        .watchUserInspections(currentUser.uid)
        .listen(
      (inspectionList) {
        inspections.assignAll(inspectionList);
        isLoading.value = false;
        errorMessage.value = '';
      },
      onError: (error) {
        errorMessage.value =
            'No se pudieron cargar las inspecciones.';
        isLoading.value = false;
      },
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
