import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminder/screensetting/provider/Users.dart';
import 'package:waterreminder/screensetting/routes/AppRoutes.dart';
import 'package:waterreminder/screensetting/views/User-Form.dart';
import 'package:waterreminder/screensetting/views/UserList.dart';

class MySetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Users()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.USER_HOME: (_) => UserForm(),
        },
      ),
    );
  }
}
