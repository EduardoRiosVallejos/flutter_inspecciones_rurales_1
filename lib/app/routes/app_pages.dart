import 'package:get/get.dart';

import '../modules/initial/initial_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.initial,
      page: () => const InitialView(),
    ),
  ];
}