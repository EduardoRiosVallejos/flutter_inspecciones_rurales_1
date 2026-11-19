
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/inspection_model.dart';

class InspectionProvider {
  final FirebaseFirestore _firestore;

  InspectionProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
      get _inspectionsCollection =>
          _firestore.collection('inspections');

  // Generar ID antes de guardar la inspección.
  String generateInspectionId() {
    return _inspectionsCollection.doc().id;
  }

  // Crear inspección sin esperar la confirmación del servidor.
  void createInspection(InspectionModel inspection) {
    debugPrint('INSPECCIÓN ENVIADA A FIRESTORE: ${inspection.id}');

    final writeFuture = _inspectionsCollection
        .doc(inspection.id)
        .set(inspection.toFirestore());

    unawaited(
      writeFuture.then((_) {
        debugPrint(
          'INSPECCIÓN SINCRONIZADA CON FIRESTORE: ${inspection.id}',
        );
      }).catchError((Object error) {
        debugPrint(
          'ERROR AL SINCRONIZAR INSPECCIÓN ${inspection.id}: $error',
        );
      }),
    );
  }

  // Obtener una inspección por su ID.
  Future<InspectionModel?> getInspection(String id) async {
    final document = await _inspectionsCollection.doc(id).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return InspectionModel.fromFirestore(
      document.data()!,
      document.id,
    );
  }

  // Obtener las inspecciones de un usuario una sola vez.
  Future<List<InspectionModel>> getUserInspections(
    String userId,
  ) async {
    final query = await _inspectionsCollection
        .where('userId', isEqualTo: userId)
        .get();

    return query.docs
        .map(
          (document) => InspectionModel.fromFirestore(
            document.data(),
            document.id,
          ),
        )
        .toList();
  }

  // Escuchar las inspecciones del usuario en tiempo real.
  Stream<List<InspectionModel>> watchUserInspections(
    String userId,
  ) {
    return _inspectionsCollection
        .where('userId', isEqualTo: userId)
        .snapshots(includeMetadataChanges: true)
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => InspectionModel.fromFirestore(
                  document.data(),
                  document.id,
                ),
              )
              .toList(),
        );
  }
}
