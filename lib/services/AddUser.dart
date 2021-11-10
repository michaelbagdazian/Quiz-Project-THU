import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_pro/main.dart';
import 'User.dart';
import 'package:json_annotation/json_annotation.dart';

class AddUser {
  final _fireBase = FirebaseFirestore.instance;
  final _UserCollection = FirebaseFirestore.instance.collection('Users');
  void addUser(String _UserId, String _email, String _username) {
    User _user = new User(_username, _email, _UserId);
    //adding an avatar for the user
    _user.setCircleAvatar('assets/avatar/generic_robo.png');
    //converting the user object to a json object
    Map<String, dynamic> _userData = _user.toJson();
    //adding the user json object to the firebase
    _UserCollection.doc(_UserId).set(_userData);
  }
}
