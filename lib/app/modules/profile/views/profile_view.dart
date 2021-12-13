import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:waterreminder/app/global_widgets/user_avatar.dart';
import 'package:waterreminder/app/modules/profile/controllers/profile_controller.dart';
import 'package:waterreminder/app/modules/profile/views/account_details_view.dart';
import 'package:waterreminder/app/theme/text_theme.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController fController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      appBar: AppBar(
        title:Text('ข้อมูลส่วนตัว',),
      ),
      body: Container(
        color: Colors.blue[200],
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                height: size.height * 0.18,
                width: size.width * 0.90,
                decoration: BoxDecoration(
                  color: Color(0xFFF0F8FF),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [kDefaultShadow],
                ),
                child: GetBuilder<ProfileController>(
                    id: 7,
                    builder: (_) {
                      return Row(
                        children: [
                          UserAvatar(
                            radius: size.width * 0.085,
                            ismale: fController.isMale,
                          ),
                          SizedBox(width: size.width * 0.045),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${fController.fName} ${fController.lName}',
                                style: kSub2HeadTextStyle.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${'เป้าหมาย ' + fController.Drink + ' ml'}',
                                style: kSub2HeadTextStyle.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    })),
            SizedBox(
              height: size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => AccountDetailsView());
                fController.preEditUser();
              }, child: Text('แก้ไขข้อมูล',
                  style: kSub2HeadTextStyle.copyWith(
                  color: Color(0xFFFFFFFF),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
