// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/main.dart';
import 'package:test_pro/services/AddUser.dart';
import 'package:test_pro/services/UploadImageToFireStorage.dart';

class Authentication {
  //Just some Objects
  final AddUser _addUser = AddUser();
  final _auth = FirebaseAuth.instance;
  /* registeration method, the arguments are:
  TextEditingController _username: to get the user name that was typed in by the user
  TextEditingController _email: to get the user's email
  TextEditingController _passwd: to get the user's password, but not in a bad way ;)
  TextEditingController _passconfirm: to check if the user has typed in the right password
  bool _checked: which is to check if the checkbox on the registeration page is checked; if you want to reuse this method for some reason, make this nullable by adding ?
  BuildContext _context: to get the context of the registeration page; in this method, this is used for text dialog and other things 
  */
  void register(
      TextEditingController _username,
      TextEditingController _email,
      TextEditingController _passwd,
      TextEditingController _passconfirm,
      bool _checked,
      BuildContext _context) async {
    //check if the user has typed the right password in and didn't missclick
    //also check if the checkbox is checked
    if (_passwd.text == _passconfirm.text && _checked == true) {
      try {
        //TODO: find a way to hook the username to a user
        final _user = await _auth.createUserWithEmailAndPassword(
          email: _email.text,
          password: _passwd.text,
        );
        //this is just a small bar on the bottom of the sccreen that appears for 5 seconds and says that the registration is complete
        ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(
          content: Text('Registration Complete'),
          duration: Duration(seconds: 5),
        ));
        //calls the method addUser to add the newly registered User
        _addUser.addUser(_user.user!.uid, _email.text, _username.text);
        //go back to the home page
        Navigator.of(_context).pop();
      }
      //exceptions
      //the error messages are already taken care of thanks to firebase
      on FirebaseAuthException catch (e) {
        showDialog(
          context: _context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              "Ops! An Error Happend", //maybe change this if you want to; it is just a place holder
              style: TextStyle(
                fontFamily: 'Lobster',
                fontSize: 40,
              ),
            ),
            content: Text('${e.message}'),
          ),
        );
      }
    }
    //this happens incase the checkbox isn't checked or the password confirmation is wrong
    else {
      String msg = (_checked == false)
          ? "Agree to terms of use first"
          : "Password and Password's Confirmation are different";
      showDialog(
        context: _context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Validation",
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 40,
            ),
          ),
          content: Text(msg),
        ),
      );
    }
  }
  /* login method, the arguments are:
  TextEditingController _email: to get the user's email
  TextEditingController _passwd: to get the user's password
  BuildContext _context: to get the context of the registeration page; in this method, this is used for text dialog and other things 
  */

  void login(TextEditingController _email, TextEditingController _passwd,
      BuildContext _context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _passwd.text);
      //Assigning the logged in User's data to the global UserDats
      //this makes everything easier when we want to display User's Info on User's Profile
      //!this needs further development please ignore for now
      UserDats = FirebaseFirestore.instance
          .collection('Users')
          //this statement is to fetch document from firebase collection 'Users' by UID
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .asStream();
      UploadFileToFireStorage uploadFileToFireStorage =
          UploadFileToFireStorage();
      //! These should be changed
      await Navigator.pushReplacementNamed(_context, '/home', arguments: {
        'accountName': 'nick',
        'accountEmail': _email.text,
        'avatar': 'daniel.jpg',
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: _context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Ops! Login Failed",
            style: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 40,
            ),
          ),
          content: Text('${e.message}'),
        ),
      );
    }
  }
}
