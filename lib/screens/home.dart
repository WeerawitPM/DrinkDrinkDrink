import 'package:flutter/material.dart';
import 'package:waterreminder/screens/home_screen.dart';
import 'package:waterreminder/screens/settings.dart';
import 'package:waterreminder/screens/statistics.dart';
import 'package:waterreminder/views/alarm_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	int currentTab=0;

	final List<Widget> screens = [
		HomeScreen(),
		Settings(),
		Statistics(),
    AlarmPage()
	];

	Widget currentScreen = HomeScreen();

	final PageStorageBucket bucket = PageStorageBucket();
	updateState(id){
		setState(() {
			currentTab = id;
		});
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: PageStorage(
				child: currentScreen,
				bucket: bucket,
			),
			
			bottomNavigationBar: BottomAppBar(
				shape: CircularNotchedRectangle(),
				child: Container(
					height:56,
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children: <Widget>[

              IconButton(
								icon: Icon(Icons.home,color: currentTab==0?Colors.blue:Colors.blueGrey,),
								onPressed: (){
									setState(() {
										currentScreen=HomeScreen();
										currentTab=0;
									});
								},
							),

							IconButton(
								icon: Icon(Icons.analytics,color: currentTab==1?Colors.blue:Colors.blueGrey,),
								onPressed: (){
									setState(() {
										currentScreen=Statistics();
										currentTab=1;
									});
								},
							),
              
              IconButton(
								icon: Icon(Icons.alarm,color: currentTab==2?Colors.blue:Colors.blueGrey,),
								onPressed: (){
									setState(() {
										currentScreen=AlarmPage();
										currentTab=2;
									});
								},
							),

							IconButton(
								icon: Icon(Icons.settings,color: currentTab==3?Colors.blue:Colors.blueGrey,),
								onPressed: (){
									setState(() {
										currentScreen=Settings();
										currentTab=3;
									});
								},
							),

						],
					),
				),

			),

			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

		);	
	}
}