import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waterreminder/app/global_widgets/input_text_feild.dart';
import 'package:waterreminder/app/global_widgets/proceed_button.dart';
import 'package:waterreminder/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:waterreminder/app/theme/text_theme.dart';

class LoginView extends GetView<WelcomeController> {
  final WelcomeController controller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
              top: size.height * 0.12,
              left: size.width * 0.15,
              right: size.width * 0.15),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ข้อมูลส่วนตัว',
                style: kSub2HeadTextStyle.copyWith(
                  fontSize: 20,
                ),
                ),
              // Container(
              //   height: size.width * 0.35,
              //   width: size.width * 0.35,
              //   padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              //   decoration: BoxDecoration(
              //     color: Color(0xffeeeeee),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
                // child: Image.asset(
                //   'assets/icons/logo192.png',
                // ),
              // ),
              SizedBox(height: size.height * 0.08),
              InputTextFormField(
                validator: controller.fNameValidator,
                hintText: 'ชื่อ',
                tController: controller.firstNameController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                validator: controller.lNameValidator,
                hintText: 'นามสกุล',
                tController: controller.lastNameController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                validator: controller.WeightValidator,
                hintText: 'น้ำหนัก',
                tController: controller.WeightController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                validator: controller.lNameValidator,
                hintText: 'ส่วนสูง',
                tController: controller.HeightController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                validator: controller.DrinkValidator,
                hintText: 'เป้าหมาย',
                tController: controller.DrinkController,
              ),
              SizedBox(height: size.height * 0.03),
              GetBuilder<WelcomeController>(
                id: 5,
                builder: (_) => ToggleButtons(
                  children: [
                    Image(image: AssetImage('assets/images/male-user-1.png')),
                    Image(image: AssetImage('assets/images/female-user-1.png')),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffeeeeee),
                  renderBorder: false,
                  fillColor: Color(0x000000).withOpacity(0.68),
                  splashColor: Color(0x000000),
                  constraints: BoxConstraints.expand(
                      height: size.width * 0.14, width: size.width * 0.14),
                  isSelected: controller.selectedToggleGender,
                  onPressed: controller.onToggledGender,
                ),
              ),
              SizedBox(height: size.height * 0.07),
              ProceedButton(
                size: size,
                onPress: () {
                  controller.userLogin();
                },
                title: 'ยืนยัน',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
