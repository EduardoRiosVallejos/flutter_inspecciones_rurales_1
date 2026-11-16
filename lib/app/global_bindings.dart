import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    // Los servicios globales se irán registrando
    // únicamente en las fases correspondientes.
  }
}