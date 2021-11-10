// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_new

/*
Hello My Freind
This is a class to add a User and their Information to Firebase
as you can see it hase one method which is addUser(...)
this Method Takes 3 Arguments 'for now':
String UserId: The Id of the User we want to add
String _email: The Email of the User we want to add
String _username: You see where i am going with this right? 
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';

class AddUser {
  final _UserCollection = FirebaseFirestore.instance.collection('Users');
  void addUser(String UserId, String _email, String _username) {
    //create a new User from our User Class and pass arguments that can useful later
    User _user = new User(_username, _email, UserId);
    //adding an avatar for the user
    _user.setCircleAvatar('assets/avatar/generic_robo.png');
    //converting the user object to a json object
    Map<String, dynamic> _userData = _user.toJson();
    //adding the user json object to the firebase
    _UserCollection.doc(UserId).set(_userData);
  }
}
