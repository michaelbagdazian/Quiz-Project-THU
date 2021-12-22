// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

/*
This customTextField is very reusable
it takes the following arguments:
TextEditingController _textEditingController: to actually listen to the text that has been typed in
String _label: a label
double _width: width of the field
TextInputType _textInputType: this is to handle multiple textinput types, if you don't know what to use just use text
{bool obsecured = false}: default argument that can be set to true in case you want the input text to be obsecured; use with passwords

Text Fields documentaion (please visit if you are not sure what is being done inside this customTextField): 
https://flutter.dev/docs/cookbook/forms/text-input

 */
class CustomTextField {
  Widget customTextField(TextEditingController _textEditingController,
      String _label, double _width, TextInputType _textInputType,
      {bool obsecured = false, String hint = ''}) {
    return SizedBox(
      width: _width,
      child: TextField(
        obscureText: obsecured,
        keyboardType: _textInputType,
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: hint,
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
