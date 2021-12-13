import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waterreminder/app/data/model/user_model.dart';
import 'package:waterreminder/screens/home.dart';

class WelcomeController extends GetxController {
  List<bool> selectedToggleGender;

  // Text feild controllers for login.
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController WeightController;
  TextEditingController HeightController;
  TextEditingController DrinkController;

  // instance of Get Storage
  final userData = GetStorage();

  // stire loginStatus
  bool isLoggedIn;

  // instance of userData model
  User user;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    WeightController = TextEditingController();
    HeightController = TextEditingController();
    DrinkController = TextEditingController();
    selectedToggleGender = [false, false];
    userData.writeIfNull('fName', 'Name');
    userData.writeIfNull('lName', 'SurName');
    userData.writeIfNull('Weight', 'any');
    userData.writeIfNull('Height', 'any');
    userData.writeIfNull('Drink', 'any');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    WeightController?.dispose();
    HeightController?.dispose();
    DrinkController?.dispose();
  }

  //function to toggle gender in log in screen
  onToggledGender(int index) {
    if (index == 0) {
      selectedToggleGender[index] = !selectedToggleGender[index];
      if (selectedToggleGender[index] == true) {
        selectedToggleGender[1] = false;
      }
    }
    if (index == 1) {
      selectedToggleGender[index] = !selectedToggleGender[index];
      if (selectedToggleGender[index] == true) {
        selectedToggleGender[0] = false;
      }
    }
    update([5, true]);
  }

  // FirstName validator
  String fNameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your first name';
    }
  }

  // LastName validator
  String lNameValidator(String value) {
    if (value.isEmpty) {
      return null;
    }
  }

    String WeightValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your Weight';
    }
  }

    String HeightValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your Height';
    }
  }

    String DrinkValidator(String value) {
    if (value.isEmpty) {
      return 'เป้าหมาย';
    }
  }

  // function to validate creds
  bool validateCreds() {
    bool validated = false;
    if (fNameValidator(firstNameController.text) == null &&
        lNameValidator(lastNameController.text) == null &&
        WeightValidator(WeightController.text) == null &&
        HeightValidator(HeightController.text) == null &&
        DrinkValidator(DrinkController.text) == null &&
        selectedToggleGender.contains(true)) {
      validated = true;
    } else {
      validated = false;
    }
    return validated;
  }

  // function to login to app
  userLogin() {
    if (validateCreds()) {
      user = User();
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.Weight = WeightController.text;
      user.Height = HeightController.text;
      user.Drink = DrinkController.text;
      user.isMale = selectedToggleGender.first;
      userData.write('fName', user.firstName);
      userData.write('lName', user.lastName);
      userData.write('Weight', user.Weight);
      userData.write('Height', user.Height);
      userData.write('Drink', user.Drink);
      userData.write('isMale', user.isMale);
      userData.write('loginStatus', true);
      Get.offAll(() => Home());
    }
  }
}
