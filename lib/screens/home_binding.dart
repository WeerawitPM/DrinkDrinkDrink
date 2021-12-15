import 'package:get/get.dart';
import 'package:waterreminder/screens/home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Home>(
      () => Home(),
    );
  }
}
