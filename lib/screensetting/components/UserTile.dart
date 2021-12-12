import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminder/screensetting/models/User.dart';
import 'package:waterreminder/screensetting/provider/Users.dart';
import 'package:waterreminder/screensetting/routes/AppRoutes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text('เป้าหมาย' + ' ' + user.drink + 'ml'),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            Text('              '),
            IconButton(
                icon: Icon(
                  Icons.edit, 
                  color: Colors.blue),
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.USER_HOME
                  ,arguments: user)
                ),
          ],
        ),
      ),
    );
  }
}
