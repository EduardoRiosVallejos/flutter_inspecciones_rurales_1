import '../modules/home/bindings/home_binding.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';

import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

import '../modules/home/views/home_view.dart';

import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

import 'app_routes.dart';

import '../modules/inspection_form/bindings/inspection_form_binding.dart';
import '../modules/inspection_form/views/inspection_form_view.dart';

import '../modules/inspections/bindings/inspection_list_binding.dart';
import '../modules/inspections/views/inspection_list_view.dart';

import '../modules/inspection_detail/bindings/inspection_detail_binding.dart';
import '../modules/inspection_detail/views/inspection_detail_view.dart';

import '../modules/inspection_edit/bindings/inspection_edit_binding.dart';
import '../modules/inspection_edit/views/inspection_edit_view.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.inspectionForm,
      page: () => const InspectionFormView(),
      binding: InspectionFormBinding(),
    ),
    GetPage(
      name: AppRoutes.inspections,
      page: () => const InspectionListView(),
      binding: InspectionListBinding(),
    ),
    GetPage(
      name: AppRoutes.inspectionDetail,
      page: () => const InspectionDetailView(),
      binding: InspectionDetailBinding(),
    ),
    GetPage(
    name: AppRoutes.inspectionEdit,
    page: () => const InspectionEditView(),
    binding: InspectionEditBinding(),
  ),
  ];
}
