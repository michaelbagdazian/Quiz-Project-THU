// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class extends a statlessWidget; the purpose of this class is to return an AlertBox with an error message and a label
/* 
~ As you can see, this class takes 4 parameteres:
_label: which is the label of the alertbox
_message: which is the error message
fontFamily[default parameter with value -> "Lobster"]: this is the fontFamily you want to use
fontSize[default parameter with value -> "40"]: the font size of your Label
*/

class customAlertBox extends StatelessWidget {
  late final String _label; //label of alertbox
  late final String? _message; //error message
  late String fontFamily; //font family of your label
  late double fontSize; //font size of your label

  // * this is a constructor that takes 4 parameters (only 2 of them are required)
  /*
  ! Required parameters are :
  !     _label: label of alertbox
  !     _message: error Message
  ! Optional parameters are:
  !     _fontFamily: font family your label
  !     _fontSize: font size of your label
  */
  customAlertBox(this._label, this._message,
      {Key? key, this.fontFamily = "Lobster", this.fontSize = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //the title/label of the AlertBox
      title: Text(
        _label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
        ),
      ),
      //the error message
      content: Text(_message!),
    );
  }
}
