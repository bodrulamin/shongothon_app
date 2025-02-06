import 'package:get/get.dart';

import '../../pages/committee_list/bindings/committee_list_binding.dart';
import '../../pages/committee_list/views/committee_list_view.dart';
import '../../pages/home/bindings/home_binding.dart';
import '../../pages/home/views/home_view.dart';
import '../../pages/signin/bindings/signin_binding.dart';
import '../../pages/signin/views/signin_view.dart';
import '../../pages/signup/bindings/signup_binding.dart';
import '../../pages/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.COMMITTEE_LIST,
      page: () => const CommitteeListView(),
      binding: CommitteeListBinding(),
      children: [
        GetPage(
          name: _Paths.COMMITTEE_LIST,
          page: () => const CommitteeListView(),
          binding: CommitteeListBinding(),
        ),
      ],
    ),
  ];
}
