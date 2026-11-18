
import 'package:cloud_firestore/cloud_firestore.dart';

class InspectionModel {
  final String id;
  final String userId;
  final String title;
  final String type;
  final String description;
  final String observations;
  final String status;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  InspectionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.description,
    this.observations = '',
    required this.status,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InspectionModel.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return InspectionModel(
      id: documentId,
      userId: data['userId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      type: data['type'] as String? ?? '',
      description: data['description'] as String? ?? '',
      observations: data['observations'] as String? ?? '',
      status: data['status'] as String? ?? 'open',
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'type': type,
      'description': description,
      'observations': observations,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  InspectionModel copyWith({
    String? title,
    String? type,
    String? description,
    String? observations,
    String? status,
    double? latitude,
    double? longitude,
    DateTime? updatedAt,
  }) {
    return InspectionModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      observations: observations ?? this.observations,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
