// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_pro/pages/homePage.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  void register(
      TextEditingController _username,
      TextEditingController _email,
      TextEditingController _passwd,
      TextEditingController _passconfirm,
      bool _checked,
      _context) async {
    if (_passwd.text == _passconfirm.text && _checked == true) {
      try {
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
    } else {
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

  void login(TextEditingController _email, TextEditingController _passwd,
      BuildContext _context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _passwd.text);
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
