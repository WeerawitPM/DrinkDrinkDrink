import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:waterreminder/main_setting.dart';
import 'package:waterreminder/models/Daily.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> showScheduleAtWorkweekDay(int id) async {
//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id,
//         channelKey: 'scheduled',
//         title: 'Drink water!!!',
//         body: 'ถึงเวลาดื่มน้ำแล้ว!!!',
//         payload: {'uuid': 'uuid-test'}
//       ),
//       schedule: NotificationSchedule(
//         crontabSchedule: CronHelper.instance.hourly(
//           referenceUtcDate:new DateTime(1).toLocal()
//         )
//       )
//   );
// }

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();

  final pathDirecory = await p.getApplicationDocumentsDirectory();
  
  Hive.init(pathDirecory.path);
  Hive.registerAdapter(DailyAdapter());
  
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'EN'), Locale('tr', 'TR')],
      path: 'assets/lang', // <-- change the path of the translation files 
      fallbackLocale: Locale('en', 'EN'),
      child: App()
    ),
  );
  
}

class App extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  
  @override
  Widget build(BuildContext context) {
  
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white
    ));
	  return MaterialApp(
      
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      
			title: 'Drink Drink Drink', //ชื่อหัวข้อแอพ
			debugShowCheckedModeBanner: false,
			home: FutureBuilder(
        future:Hive.openBox('dailys'),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return MySetting();
          }
          else{
            return Scaffold();
          }
      })
	  );
  }

  @override
  void dispose() {
    Hive.box('dailys').close();
    super.dispose();
  }
}