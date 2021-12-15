import 'package:get/get.dart';
import 'package:waterreminder/app/modules/profile/bindings/profile_binding.dart';
import 'package:waterreminder/app/modules/profile/views/profile_view.dart';
import 'package:waterreminder/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:waterreminder/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:waterreminder/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:waterreminder/app/modules/welcome/views/login_view.dart';
import 'package:waterreminder/screens/home.dart';
import 'package:waterreminder/screens/home_binding.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => LoginView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
      binding: HomeBinding(),
    ),
  ];
}
