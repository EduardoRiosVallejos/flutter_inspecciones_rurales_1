
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/auth_provider.dart' as app_auth;

class AuthRepository {
  final app_auth.AuthProvider _authProvider;

  AuthRepository({
    required this._authProvider,
  });

  // Obtener el usuario actual
  User? get currentUser => _authProvider.currentUser;

  // Escuchar cambios de autenticación
  Stream<User?> get authStateChanges =>
      _authProvider.authStateChanges;

  // Registrar usuario
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _authProvider.createUser(
      email: email,
      password: password,
    );
  }

  // Iniciar sesión
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _authProvider.signIn(
      email: email,
      password: password,
    );
  }

  // Recuperar contraseña
  Future<void> resetPassword({
    required String email,
  }) async {
    await _authProvider.sendPasswordResetEmail(
      email: email,
    );
  }

  // Cerrar sesión
  Future<void> logout() async {
    await _authProvider.signOut();
  }
}
