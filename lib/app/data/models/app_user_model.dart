
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUserModel.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return AppUserModel(
      uid: documentId,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  AppUserModel copyWith({
    String? name,
    String? email,
    DateTime? updatedAt,
  }) {
    return AppUserModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
