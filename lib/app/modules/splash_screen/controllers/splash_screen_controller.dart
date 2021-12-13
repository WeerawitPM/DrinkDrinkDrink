import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  // animation controller for lottie
  AnimationController animationController;

  // initializing userData instance
  final userData = GetStorage();

  // store Login status
  bool isLoggedIn;

  // function to set the user saved theme on start

  // function to check loginStatus
  checkLogin() {
    isLoggedIn = userData.read('loginStatus');
  }

  @override
  void onInit() {
    super.onInit();
   // userData.writeIfNull('theme', "Yellow Light");
    userData.writeIfNull('drinkWater', false);
    userData.writeIfNull('loginStatus', false);

    // spalsh animation config
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    checkLogin();
    Timer(
      Duration(milliseconds: 5500),
      () => Get.offNamed(isLoggedIn ? '/Home' : '/welcome'),
    );
  }

  @override
  void onClose() async {
    animationController.dispose();
    super.onClose();
  }
}
