// ignore: file_names
// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_pro/customWidgets/customCircularAvatar.dart';

/*
This is User Class that is JsonSerializable which means it can be converted to Json type format
it has the following attributes:
*String _Username: which is the User name
*late String _email: email of the user
*late String UID :user ID
*late CircleAvatar Avatar: the user's avatar
*late String _pathToAvatar: path to the user's avatar
*late int _level: level of the user

it also has the following methods:
*setCircleAvatar(String path) which sets a new avatar for the user
*getLevel(): to get the level of the user
*setLevel(int level): to the set the level of the user
*toJson(): which creates a map with the User's Information
!NOTE: add achievments and work on the circular avatar

*/
@JsonSerializable()
class User {
  late String _Username;
  late String _email;
  late String UID; //user ID
  late CircleAvatar Avatar;
  late String _pathToAvatar;
  late int _level;

//create a user with a user name, and email, and a UID
  User(String _uname, String _email, String UID, this._pathToAvatar) {
    this._Username = _uname;
    this._email = _email;
    this.UID = UID;
    setCircleAvatar(_pathToAvatar);
  }
//set the avatar of a user
  void setCircleAvatar(String path) {
    //create a custom circular avatar and pass an image to it
    customCircularAvatar _circularAvatar = new customCircularAvatar(path);
    // Avatar = _circularAvatar.getCircularAvatar(path); //defenitly have to work on this later
  }

  int getLevel() {
    return _level;
  }

  void setLevel(int level) {
    _level = level;
  }

/*The following map is to convert the User class to a Json Object so we can store it easily in firebase */
  Map<String, dynamic> toJson() => {
        'UserName': _Username,
        'E-mail': _email,
        'Level': _level,
        'Avatar': _pathToAvatar,
      };
}
