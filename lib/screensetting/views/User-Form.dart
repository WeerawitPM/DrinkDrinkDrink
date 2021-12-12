import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterreminder/screensetting/models/User.dart';
import 'package:waterreminder/screensetting/provider/Users.dart';

class UserForm extends StatefulWidget {

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user){

    if(user != null){

    _formData['id'] = user.id ;
    _formData['name'] = user.name;
    _formData['gender'] = user.gender;
    _formData['weight'] = user.weight;
    _formData['height'] = user.height;
    _formData['drink'] = user.drink;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;

    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("แก้ไขข้อมูล"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () { 
              final isValid = _form.currentState.validate();
              
              if(isValid){
                _form.currentState.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'],
                  name: _formData['name'],
                  gender: _formData['gender'],
                  weight: _formData['weight'],
                  height: _formData['height'],
                  drink: _formData['drink'],
                  email: _formData['email'],
                  avatarUrl: _formData['avatarUrl'],
                ));
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          color: Colors.blue[200],
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Include your name';
                    }
                    if (value.trim().length < 3){
                      return 'Name too small';
                    }
                  },
                  onSaved: (value) => _formData['name'] = value,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  onSaved: (value) => _formData['email'] = value,                
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                TextFormField(
                  initialValue: _formData['gender'],
                  onSaved: (value) => _formData['gender'] = value,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextFormField(
                  initialValue: _formData['weight'],
                  onSaved: (value) => _formData['weight'] = value,
                  decoration: InputDecoration(labelText: 'Weight'),
                ),
                TextFormField(
                  initialValue: _formData['height'],
                  onSaved: (value) => _formData['height'] = value,
                  decoration: InputDecoration(labelText: 'Height'),
                ),
                TextFormField(
                  initialValue: _formData['drink'],
                  onSaved: (value) => _formData['drink'] = value,
                  decoration: InputDecoration(labelText: 'เป้าหมาย'),
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  onSaved: (value) => _formData['avatarUrl'] = value,
                  decoration: InputDecoration(labelText: 'Avatar URL'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}