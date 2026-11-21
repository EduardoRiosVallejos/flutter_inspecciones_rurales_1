
import '../models/inspection_model.dart';
import '../providers/inspection_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionRepository {
  final InspectionProvider _inspectionProvider;

  InspectionRepository({
    required this._inspectionProvider,
  });

  // Generar ID de inspección.
  String generateInspectionId() {
    return _inspectionProvider.generateInspectionId();
  }

  // Crear inspección.
  void createInspection(InspectionModel inspection) {
    _inspectionProvider.createInspection(inspection);
  }

  // Actualizar una inspección existente.
  void updateInspection(InspectionModel inspection) {
    _inspectionProvider.updateInspection(inspection);
  }


  // Eliminar una inspección existente.
  void deleteInspection(String inspectionId) {
    _inspectionProvider.deleteInspection(inspectionId);
  }

  // Obtener inspección por ID.
  Future<InspectionModel?> getInspection(String id) async {
    return await _inspectionProvider.getInspection(id);
  }

  // Obtener inspecciones de un usuario.
  Future<List<InspectionModel>> getUserInspections(
    String userId,
  ) async {
    return await _inspectionProvider.getUserInspections(userId);
  }

  // Escuchar inspecciones del usuario en tiempo real.
  Stream<List<InspectionModel>> watchUserInspections(
    String userId,
  ) {
    return _inspectionProvider.watchUserInspections(userId);
  }

    // Escuchar inspecciones conservando los metadatos de Firestore.
  Stream<QuerySnapshot<Map<String, dynamic>>>
      watchUserInspectionsWithMetadata(String userId) {
    return _inspectionProvider.watchUserInspectionsWithMetadata(userId);
  }
}
