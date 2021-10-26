// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HomeScreen.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

//TODO: Add the other controllers to this method
  void register(TextEditingController _email, TextEditingController _passwd,
      _context) async {
    try {
      //TODO: compare password with confirm password with if and else
      //TODO: find a way to hook the username to a user
      await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _passwd.text,
      );
      ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(
        content: Text('Registration Complete'),
        duration: Duration(seconds: 5),
      ));
      Navigator.of(_context).pop();
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: _context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Ops! An Error Happend",
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

  void login(TextEditingController _email, TextEditingController _passwd,
      BuildContext _context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _passwd.text);
      await Navigator.of(_context).push(
        MaterialPageRoute(
          builder: (contex) => HomeScreen(),
        ),
      );
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
