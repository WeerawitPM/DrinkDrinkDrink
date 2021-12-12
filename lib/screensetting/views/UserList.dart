import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminder/screensetting/components/UserTile.dart';
import 'package:waterreminder/screensetting/provider/Users.dart';
import 'package:waterreminder/screensetting/routes/AppRoutes.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('การตั้งค่า'),
      ),
      body: 
        Container(
          color: Colors.blue[200],
          child: ListView.builder(
            itemBuilder: (context, i) => UserTile(users.byIndex(i)),
            itemCount: users.count,
        ),
      ),
    );
  }
}
