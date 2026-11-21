
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Metadatos de diagnóstico Offline First.
  final RxBool isFromCache = false.obs;
  final RxBool hasPendingWrites = false.obs;
  final RxInt pendingInspectionsCount = 0.obs;

  // IDs de inspecciones con cambios pendientes.
  final RxSet<String> pendingInspectionIds = <String>{}.obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _subscription;

  @override
  void onInit() {
    super.onInit();
    loadInspections();
  }

  // Escuchar inspecciones y metadatos de Firestore.
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
        .watchUserInspectionsWithMetadata(currentUser.uid)
        .listen(
      (snapshot) {
        // Actualizar la lista de inspecciones.
        inspections.assignAll(
          snapshot.docs.map(
            (document) => InspectionModel.fromFirestore(
              document.data(),
              document.id,
            ),
          ),
        );

        // Consultar si los datos vienen de la caché.
        isFromCache.value = snapshot.metadata.isFromCache;

        // Consultar si existen escrituras pendientes.
        hasPendingWrites.value =
            snapshot.metadata.hasPendingWrites;

        // Identificar las inspecciones con escrituras pendientes.
        final pendingIds = snapshot.docs
            .where((document) => document.metadata.hasPendingWrites)
            .map((document) => document.id)
            .toSet();

        pendingInspectionIds.assignAll(pendingIds);

        pendingInspectionsCount.value = pendingIds.length;

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
