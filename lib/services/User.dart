// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_pro/customWidgets/customCircularAvatar.dart';

@JsonSerializable()
class User {
  late String _Username;
  late String _email;
  late String UID; //user ID
  late CircleAvatar Avatar;

//create a user with a user name, and email, and a UID
  User(String _uname, String _email, String UID) {
    this._Username = _uname;
    this._email = _email;
    this.UID = UID;
  }
//set the avatar of a user
  void setCircleAvatar(String path) {
    //create a custom circular avatar and pass an image to it
    customCircularAvatar _circularAvatar = new customCircularAvatar(path);
  }

/*The following map is to convert the User class to a Json Object so we can store it easily in firebase */
  Map<String, dynamic> toJson() => {
        'UserName': _Username,
        'E-mail': _email,
      };
}
