import 'package:charts_flutter/flutter.dart' as charts;
import 'package:waterreminder/models/Daily.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DailyChart extends StatelessWidget {
  final List<Daily> dailys;

  DailyChart({@required this.dailys});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Daily, String>> daily = [
      charts.Series(
          id: "Water Records",
          data: dailys,
          domainFn: (Daily daily, _) => DateFormat('EEE').format(DateTime.parse(daily.date)),
          measureFn: (Daily daily, _) => daily.drinked,
        )
    ];

    return Container(
      height: 400,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              
              Expanded(
                child: charts.BarChart(daily, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
