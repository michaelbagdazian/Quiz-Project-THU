// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
! This class is not used yet and can be ignored, however it can be used if we use text controllers to validate user's input
! by using this class we can prevent redundent code 
! it is stull not fully functional yet but it can be like the the customTextField which is fully functional
*/

class customTextFormField //States //extends State<customTextFormField> {
{
  Widget CustomTextFormField(
      String _labelText, String _hintText, void Function(void) _function) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,

      // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.yellow)),
        contentPadding: const EdgeInsets.all(15),
        labelText: _labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Lobster',
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
