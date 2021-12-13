import 'package:get/get.dart';

import 'package:waterreminder/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:waterreminder/screens/home.dart';
import 'package:waterreminder/screens/home_screen.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Home>(
      () => Home(),
    );
  }
}
