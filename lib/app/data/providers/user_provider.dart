
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user_model.dart';

class UserProvider {
  final FirebaseFirestore _firestore;

  UserProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // Crear perfil del usuario
  Future<void> createUser(AppUserModel user) async {
    await _usersCollection.doc(user.uid).set(
          user.toFirestore(),
        );
  }

  // Obtener perfil del usuario
  Future<AppUserModel?> getUser(String uid) async {
    final document = await _usersCollection.doc(uid).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return AppUserModel.fromFirestore(
      document.data()!,
      document.id,
    );
  }

  // Actualizar nombre del usuario
  Future<void> updateUserName({
    required String uid,
    required String name,
  }) async {
    await _usersCollection.doc(uid).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
