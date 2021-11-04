// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextField {
  Widget customTextField(TextEditingController _textEditingController,
      String _label, double _width, TextInputType _textInputType,
      {bool obsecured = false}) {
    return SizedBox(
      width: _width,
      child: TextField(
        obscureText: obsecured,
        keyboardType: _textInputType,
        controller: _textEditingController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.yellow)),
          contentPadding: const EdgeInsets.all(15),
          labelText: _label,
          labelStyle: const TextStyle(
            fontFamily: 'Lobster',
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
