// ignore_for_file: file_names, camel_case_types

import 'package:crew_brew/shared/customWidgets/customButton.dart';
import 'package:crew_brew/shared/customWidgets/customText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class customConfirmationBox {
  //create a bool to set an reset based on user's choice
  String label;
  String content;
  bool _confirmed = false;
  customConfirmationBox({Key? key, required this.label, required this.content});
  /*
  *The Following Widget takes two arguments:
  *String text: what is displayed on the confirmation box
  *context: the context of the screen, on which you want to build this widget
   */

  //setter for _confirmed
  //sets it to true
  VoidCallback? setConfirmed() {
    _confirmed = true;
  }

  VoidCallback? resetConfirmed() {
    _confirmed = false;
  }

  bool getConfirmed() {
    return _confirmed;
  }

  @override
  Future ConfirmPopUp(BuildContext context) async {
    bool confirm = false;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(label,
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 40,
                )),
            content: Text(content),
            actions: <Widget>[
              //* if user chooses yes, then we set _confirmed to true
              CustomButton(
                  label: 'yes',
                  backgroundcolor: Colors.orange,
                  function: () {
                    confirm = true;
                    Navigator.of(context).pop();
                  }),
              //* else we reset it to false, which is not necessary but i don't want to use null here
              CustomButton(
                  label: 'no',
                  backgroundcolor: Colors.orange,
                  function: () {
                    confirm = false;
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
    return confirm;
  }
}
