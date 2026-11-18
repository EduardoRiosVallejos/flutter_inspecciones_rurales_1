
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/app_user_model.dart';
import '../../../data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  ProfileController({
    required this._userRepository,
  });

  final Rxn<AppUserModel> userProfile = Rxn<AppUserModel>();
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  final TextEditingController nameController =
      TextEditingController();

  @override
  void onReady() {
    super.onReady();
    loadProfile();
  }

  // Consultar perfil del usuario autenticado
  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        errorMessage.value = 'No hay una sesión activa.';
        return;
      }

      final profile = await _userRepository.getUser(currentUser.uid);

      if (profile == null) {
        errorMessage.value = 'No se encontró el perfil del usuario.';
        return;
      }

      userProfile.value = profile;
      nameController.text = profile.name;
    } catch (e) {
      errorMessage.value = 'No se pudo cargar el perfil.';
    } finally {
      isLoading.value = false;
    }
  }

  // Actualizar nombre del usuario
  Future<void> updateName() async {
    final newName = nameController.text.trim();

    if (newName.isEmpty) {
      Get.snackbar(
        'Atención',
        'El nombre no puede estar vacío.',
      );
      return;
    }

    try {
      isSaving.value = true;

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        Get.snackbar(
          'Error',
          'No hay una sesión activa.',
        );
        return;
      }

      await _userRepository.updateUserName(
        uid: currentUser.uid,
        name: newName,
      );

      await loadProfile();

      Get.snackbar(
        'Perfil actualizado',
        'Tu nombre se actualizó correctamente.',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo actualizar el nombre.',
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
