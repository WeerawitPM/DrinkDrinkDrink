import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:waterreminder/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:waterreminder/app/theme/text_theme.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              //
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Drink Drink Drink',
                style: kHeadTextStyle.copyWith(
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
