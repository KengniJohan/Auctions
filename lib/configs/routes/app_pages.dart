import 'package:auctions/configs/routes/app_routes.dart';
import 'package:auctions/configs/routes/bindings/account_binding.dart';
import 'package:auctions/configs/routes/bindings/user_binding.dart';
import 'package:auctions/views/home_view.dart';
import 'package:auctions/views/auth/signin_view.dart';
import 'package:auctions/views/auth/signup_view.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> allPages = [
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignupView(),
      bindings: [UserBinding(), AccountBinding()],
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SigninView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      bindings: [UserBinding()],
    ),
  ];
}
