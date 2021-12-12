import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String gender;
  final String weight;
  final String height;
  final String drink;
  final String email;
  final String avatarUrl;

  const User(
      {this.id,
      @required this.name,
      @required this.gender,
      @required this.weight,
      @required this.height,
      @required this.drink,
      @required this.email,
      @required this.avatarUrl});
}

