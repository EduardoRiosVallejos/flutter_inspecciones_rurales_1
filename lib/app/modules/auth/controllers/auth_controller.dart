import '../../../data/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user_repository.dart';

import '../../../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;

  final UserRepository _userRepository;

  AuthController({
    required this._authService,
    required this._userRepository,
  });

  // Estados de la autenticación
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;

  // Registrar usuario

Future<bool> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    _clearMessages();
    isLoading.value = true;

    // Crear cuenta en Firebase Authentication
    final credential = await _authService.register(
      email: email.trim(),
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      errorMessage.value = 'No se pudo obtener el usuario registrado.';
      return false;
    }

    // Preparar perfil del usuario
    final now = DateTime.now();

    final appUser = AppUserModel(
      uid: firebaseUser.uid,
      name: name.trim(),
      email: firebaseUser.email ?? email.trim(),
      createdAt: now,
      updatedAt: now,
    );

    // Guardar perfil en Firestore
    await _userRepository.createUser(appUser);

    successMessage.value = 'Cuenta y perfil creados correctamente.';
    return true;
  } on FirebaseAuthException catch (e) {
    errorMessage.value = _getErrorMessage(e.code);
    return false;
  } catch (e) {
    errorMessage.value =
        'La cuenta pudo crearse, pero no se pudo guardar el perfil. Comprueba tu conexión y Firestore.';
    return false;
  } finally {
    isLoading.value = false;
  }
}


  // Iniciar sesión
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _clearMessages();
      isLoading.value = true;

      await _authService.login(
        email: email.trim(),
        password: password,
      );

      successMessage.value = 'Inicio de sesión exitoso.';
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getErrorMessage(e.code);
      return false;
    } catch (_) {
      errorMessage.value = 'Ocurrió un error inesperado.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Recuperar contraseña
  Future<bool> resetPassword({
    required String email,
  }) async {
    try {
      _clearMessages();
      isLoading.value = true;

      await _authService.resetPassword(
        email: email.trim(),
      );

      successMessage.value =
          'Se ha enviado el correo de recuperación.';
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getErrorMessage(e.code);
      return false;
    } catch (_) {
      errorMessage.value = 'No se pudo enviar el correo.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Cerrar sesión
  Future<bool> logout() async {
    try {
      _clearMessages();
      isLoading.value = true;

      await _authService.logout();

      successMessage.value = 'Sesión cerrada correctamente.';
      return true;
    } catch (_) {
      errorMessage.value = 'No se pudo cerrar la sesión.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Limpiar mensajes
  void _clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }

  // Traducir errores de Firebase
  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este correo electrónico ya está registrado.';

      case 'invalid-email':
        return 'El correo electrónico no es válido.';

      case 'weak-password':
        return 'La contraseña es demasiado débil.';

      case 'user-not-found':
        return 'No existe una cuenta con este correo.';

      case 'wrong-password':
        return 'La contraseña es incorrecta.';

      case 'invalid-credential':
        return 'El correo o la contraseña son incorrectos.';

      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';

      case 'too-many-requests':
        return 'Demasiados intentos. Inténtalo más tarde.';

      case 'network-request-failed':
        return 'Error de conexión. Comprueba tu internet.';

      case 'operation-not-allowed':
        return 'Este método de acceso no está habilitado.';

      default:
        return 'No se pudo completar la operación.';
    }
  }
}
