import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waterreminder/app/global_widgets/input_text_feild.dart';
import 'package:waterreminder/app/global_widgets/proceed_button.dart';
import 'package:waterreminder/app/modules/profile/controllers/profile_controller.dart';
import 'package:waterreminder/app/theme/text_theme.dart';

class AccountDetailsView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 25, right: 25),
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'แก้ไขข้อมูล',
                style: kSubHeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              SizedBox(height: Get.height * 0.1),
              InputTextFormField(
                validator: controller.fNameValidator,
                hintText: 'ชื่อ',
                tController: controller.firstNameController,
                textFeildColor: Theme.of(context).primaryColorLight,
                contentTextColor: Theme.of(context).primaryColorDark,
              ),
              SizedBox(height: 30),
              InputTextFormField(
                validator: controller.lNameValidator,
                hintText: 'นามสกุล',
                tController: controller.lastNameController,
                textFeildColor: Theme.of(context).primaryColorLight,
                contentTextColor: Theme.of(context).primaryColorDark,
              ),
              SizedBox(height: 30),
              InputTextFormField(
                validator: controller.WeightValidator,
                hintText: 'น้ำหนัก',
                tController: controller.WeightController,
                textFeildColor: Theme.of(context).primaryColorLight,
                contentTextColor: Theme.of(context).primaryColorDark,
              ),
              SizedBox(height: 30),
              InputTextFormField(
                validator: controller.HeightValidator,
                hintText: 'ส่วนสูง',
                tController: controller.HeightController,
                textFeildColor: Theme.of(context).primaryColorLight,
                contentTextColor: Theme.of(context).primaryColorDark,
              ),
              SizedBox(height: 30),
              InputTextFormField(
                validator: controller.DrinkValidator,
                hintText: 'เป้าหมายการดื่มน้ำ',
                tController: controller.DrinkController,
                textFeildColor: Theme.of(context).primaryColorLight,
                contentTextColor: Theme.of(context).primaryColorDark,
              ),
              SizedBox(height: Get.height * 0.05),
              GetBuilder<ProfileController>(
                id: 5,
                builder: (_) => ToggleButtons(
                  children: [
                    Image(image: AssetImage('assets/images/male-user-1.png')),
                    Image(image: AssetImage('assets/images/female-user-1.png')),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffeeeeee),
                  renderBorder: false,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.68),
                  splashColor: Theme.of(context).primaryColor,
                  constraints: BoxConstraints.expand(
                      height: Get.width * 0.14, width: Get.width * 0.14),
                  isSelected: controller.selectedToggleGender,
                  onPressed: controller.onToggledGender,
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              ProceedButton(
                size: Get.size,
                buttonColor: Theme.of(context).primaryColor.withOpacity(0.9),
                onPress: () {
                  controller.editUser();
                },
                title: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
