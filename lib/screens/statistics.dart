import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:waterreminder/components/dailyChart.dart';
import 'package:waterreminder/models/Daily.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final List<Daily> dailys= [
    
  ];
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void initState() {
    var now = new DateTime.now().toLocal();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var weekFormat = new DateFormat.yMMMMEEEEd().format(now);

    for (var i = 1; i < 8; i++) {
        Daily data = Hive.box('dailys').get(formatter.format(getDate(now.subtract(Duration(days: now.weekday - i)))));
        dailys.add(data);
    }

    Daily data = Hive.box('dailys').get(formatter.format(now));
    dailys.add(data);



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('รายงานประจำสัปดาห์',),
      ),
      body: Container(
        color: Colors.blue[200],
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter, 
        //     colors: [
        //       Color(0xFFFFFFFF),
        //       Color(0xFFFFC4C4),
        //     ],
        //   ),
        // ),
        child: Column(
          children: [
            Padding(padding:EdgeInsets.only(bottom:25)),
            DailyChart(dailys: dailys,)
          ],
        ),
      ),
    );
  }
}