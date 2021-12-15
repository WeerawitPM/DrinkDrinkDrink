import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waterreminder/app/global_widgets/bottom_sheet.dart';
import 'package:waterreminder/app/global_widgets/expandable_container.dart';
import 'package:waterreminder/app/global_widgets/user_avatar.dart';
import 'package:waterreminder/app/modules/home/controllers/home_controller.dart';
import 'package:waterreminder/app/modules/home/views/past_tasks_view.dart';
import 'package:waterreminder/app/modules/profile/views/profile_view.dart';
import 'package:waterreminder/app/theme/text_theme.dart';

class AllTasksView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งเวลาดื่มน้ำ'),
        actions: [
          IconButton(
            onPressed:(){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PastTasksView()),
              );
            }, 
            icon: Icon(Icons.restore)),
        ],
      ),
      body: Container(
      color: Colors.blue[200],
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
              ElevatedButton(onPressed: (){
                controller.controllerReset();
                showModalBottomSheet(
                  backgroundColor: Color(0xFFFFCCFF),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BottomSheetContent(
                      buttonText: 'ยืนยัน',
                      onSubmit: () {
                        controller.addTask();
                },
              );
            },
          );
              }, child:
              Icon(Icons.add,size: 50,color: Color(0xFFFFFFFF),),
              ),
            SizedBox(height: Get.height * 0.025),
            GetBuilder<HomeController>(
              id: 1,
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final task = controller.commingTasks[index];
                      return Slidable(
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.2,
                        controller: controller.slideC,
                        child: ExpandedContainer(
                          icon: task.taskImage,
                          title: task.taskTitle,
                          time: task.startTime,
                          desc: task.taskDesc,
                          ifDate: true,
                          date: DateFormat.yMMMd().format(task.taskDate),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: Get.width * 0.05,
                                left: Get.width * 0.07),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 26,
                                     color:Color(0xFF000000),
                                  ),
                                  onPressed: () {
                                    controller.slideC.activeState?.close();
                                    Slidable.of(context)?.close();
                                    controller.preUpdateTask(task);
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetContent(
                                          buttonText: 'แก้ไข',
                                          onSubmit: () {
                                            controller.updateTask(task);
                                          },
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ],
                        secondaryActions: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: Get.width * 0.05,
                                right: Get.width * 0.07),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 26,
                                    color: Color(0xFFFF0000),
                                  ),
                                  onPressed: () {
                                    controller.slideC.activeState?.close();
                                    Slidable.of(context)?.close();
                                    controller.customDialogDel(context, task);
                                  }),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: controller.commingTasks.length,
                  ),
                );
              },
            ),
          ],
        ),
        ),
      );
  }
}
