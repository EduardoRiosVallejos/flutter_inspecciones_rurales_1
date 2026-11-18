
import '../models/app_user_model.dart';
import '../providers/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository(this._userProvider);

  // Crear perfil del usuario
  Future<void> createUser(AppUserModel user) async {
    await _userProvider.createUser(user);
  }

  // Obtener perfil del usuario
  Future<AppUserModel?> getUser(String uid) async {
    return await _userProvider.getUser(uid);
  }

  // Actualizar nombre del usuario
  Future<void> updateUserName({
    required String uid,
    required String name,
  }) async {
    await _userProvider.updateUserName(
      uid: uid,
      name: name,
    );
  }
}
