
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        final user = controller.userProfile.value;

        if (user == null) {
          return const Center(
            child: Text('No hay información del perfil.'),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Nombre',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Escribe tu nombre',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Correo electrónico',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(user.email),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.isSaving.value
                          ? null
                          : controller.updateName,
                      icon: controller.isSaving.value
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.save),
                      label: Text(
                        controller.isSaving.value
                            ? 'Guardando...'
                            : 'Guardar cambios',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
