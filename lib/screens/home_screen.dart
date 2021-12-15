import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:waterreminder/models/Daily.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
	double drinked = 0;
  
	double goal = 2600;
	bool didReached = false;
  List activities = [];
  List icons =[
    {'size':150,'name':'assets/icons/150.svg'},
  ];
  var todaysDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool _notificationsAllowed = false;

  var now = new DateTime.now().toLocal();
  var formatter = new DateFormat('yyyy-MM-dd');
  
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  createWeeklyEmptyData(){

    String yesterday = formatter.format(getDate(now.subtract(Duration(days: now.weekday - 1))));
    print(yesterday);
    
    if (getDailyData(yesterday)!=null) {
      // pass
      print('none');
    }else{
      // create past data
      for (var i = 1; i < now.weekday-getDate(now.subtract(Duration(days: now.weekday - 1))).weekday+1; i++) {
        try {
          Daily emptyDaily = new Daily(formatter.format(getDate(now.subtract(Duration(days: now.weekday - i)))),0.toInt(),false,[]);
          Hive.box('dailys').put(formatter.format(getDate(now.subtract(Duration(days: now.weekday - i)))),emptyDaily);
        } catch (e) {
          print(e);
        }
      }
    }
    
    String tommorow = formatter.format(getDate(now.subtract(Duration(days: 1-now.weekday))));
    print(tommorow);
    
    if(getDailyData(tommorow)!=null){
      print('none');
    }
    else{
      // create present data
      for (var i = now.weekday+1; i < getDate(now.add(Duration(days: DateTime.daysPerWeek -now.weekday))).weekday+1; i++) {
        try {
          Daily emptyDaily = new Daily(formatter.format(getDate(now.subtract(Duration(days: now.weekday - i)))),0.toInt(),false,[]);
          Hive.box('dailys').put(formatter.format(getDate(now.subtract(Duration(days: now.weekday - i)))),emptyDaily);    
        } catch (e) {
          print(e);
        }
      }
    }
  }
  
  getDailyData(String date){
    try {
      Daily data = Hive.box('dailys').get(date);
      return data.toMap();
    } catch (e) {
      return null;
    }
  }

  createDailyData(String date,value){
    return Hive.box('dailys').put(date, value);
  }

  @override
  void initState() {
    
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      _notificationsAllowed = isAllowed;
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    
    createWeeklyEmptyData();

    try {
      if(getDailyData(formattedDate)!=null){
        int drinkedWater = getDailyData(formattedDate)['drinked'];
        List activitiesList = getDailyData(formattedDate)['activities']; 

        setState(() {
          drinked += drinkedWater;
          activities += activitiesList;
        });
      }
      else{
        Daily newDaily = new Daily(formattedDate,drinked.toInt(),didReached,activities);
        createDailyData(formattedDate,newDaily);
        return print('data created for:${formattedDate}');
      }
    } catch (e) {
      print('error');
    }
    super.initState();
  }



	@override
	Widget build(BuildContext context) {

	  String percent = ((drinked/goal)*100).floor().toString();
    final format = DateFormat('HH:mm a');

		return Scaffold(
			
			body: Container(
        color: Colors.blue[200],
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            CircularPercentIndicator(
              header: Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
              radius: 300.0,
              lineWidth: 10.0,
              animation: true,
              animationDuration: 500,
              percent:drinked>=2600?1.0:drinked/goal,
              center:Text(percent+'%',style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                          )),
                    circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey[200],
              progressColor: Colors.blue,
              animateFromLastPercent: false,
            ),
            Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            Row(
              children: [
                Expanded(
                  child: Column(
                      children: [
                        Text('วันนี้',style: TextStyle(
                          fontSize: 23,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600
                        )),
                        Text(drinked.toInt().toString()+'mL',style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('เป้าหมาย',style: TextStyle(
                        fontSize: 23,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600
                      )),
                      Text(goal.toInt().toString()+' mL',style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ))
                    ],
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            Column(
              children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: ()=>{
                      showBarModalBottomSheet(
                        expand: false,
                        bounce: false,
                        useRootNavigator: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: 450,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 35)),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '100',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 100;
                                                activities.add({'drinked':100,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('100ml')  
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '200ml',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 200;
                                                activities.add({'drinked':200,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('200ml')  
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '300ml',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 300;
                                                activities.add({'drinked':300,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('300ml')  
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                               Row(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 35)),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '400ml',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 400;
                                                activities.add({'drinked':400,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('400ml')  
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '500ml',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 500;
                                                activities.add({'drinked':500,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('500ml')  
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.only(top:50,left:50,right:50)),
                                          IconButton(
                                            iconSize: 56,
                                            icon: SvgPicture.asset(
                                              icons[0]['name'].toString(),

                                            ),
                                            tooltip: '600ml',
                                            onPressed: ()=>{
                                              setState((){
                                                drinked += 600;
                                                activities.add({'drinked':600,'date':DateTime.now().toLocal().toString()});
                                              }),
                                              print(activities.length),
                                              if(drinked.toInt()>=goal){
                                                didReached = true
                                              },
                                              createDailyData(todaysDate,new Daily(todaysDate,drinked.toInt(),didReached,activities)),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          Text('600ml')  
                                        ],
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      ),
                    }, child: Text('Drink Water'))
                ],
            ),
            Padding(
              padding: EdgeInsets.only(top:24.0,bottom: 24.00,left: 12.00),
              child: Text('Records',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            ),
            Row(
              children: [
                Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: activities.length,
                      shrinkWrap: true ,
                      itemBuilder: (context, index) =>
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset('assets/icons/drop.png'),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                          ),
                          title: Text('Drinked:${activities[activities.length-(index+1)]['drinked'].toString() }ml'),
                          subtitle: Text('Today ${format.format(DateTime.parse(activities[activities.length-(index+1)]['date']))}'),
                        ),
                      ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
		);
	}
}
