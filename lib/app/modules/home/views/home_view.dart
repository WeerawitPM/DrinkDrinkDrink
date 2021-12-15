import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterreminder/app/modules/home/controllers/home_controller.dart';
import 'package:waterreminder/app/modules/home/views/all_tasks_view.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    controller.getUser();
    return AllTasksView();
  }
}
