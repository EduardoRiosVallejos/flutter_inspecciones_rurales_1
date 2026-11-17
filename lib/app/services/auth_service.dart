
import 'package:firebase_auth/firebase_auth.dart';

import '../data/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService({
    required this._authRepository,
  });

  // Obtener usuario actual
  User? get currentUser => _authRepository.currentUser;

  // Escuchar cambios de autenticación
  Stream<User?> get authStateChanges =>
      _authRepository.authStateChanges;

  // Registrar usuario
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _authRepository.register(
      email: email,
      password: password,
    );
  }

  // Iniciar sesión
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(
      email: email,
      password: password,
    );
  }

  // Recuperar contraseña
  Future<void> resetPassword({
    required String email,
  }) async {
    await _authRepository.resetPassword(
      email: email,
    );
  }

  // Cerrar sesión
  Future<void> logout() async {
    await _authRepository.logout();
  }
}
