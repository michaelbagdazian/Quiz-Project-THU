// ignore_for_file: file_names, camel_case_types

import 'package:crew_brew/shared/customWidgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ! Information about the class:
// ~ It displays a confirmation box
// ~ This class has one Future function that displays a widget and returns a bool
// ! Use of the class:
// ~ This is used when we want to prompt the user for confirmation
// ~ the Future returns a bool to determine whether the user has confirmed or not
class customConfirmationBox {
  String label; //Label on Confirmation Box (e.g: please confirm)
  String
      content; //Content of the Confirmation box (e.g: Are you sure you want to delete this? )
  customConfirmationBox({Key? key, required this.label, required this.content});
  /*
  *The Following Future takes one arguments:
  *context: the context of the screen, on which you want to Alert Boxes
   */

  Future ConfirmPopUp(BuildContext context) async {
    // Create a bool to actually change based on user's input, and return it later
    bool confirm = false;
    // Show Dialog => show the alert box
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(label,
                style: const TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 40,
                )),
            content: Text(content),
            //Alert Box has two Actions
            actions: <Widget>[
              //custom Button 'YES'
              CustomButton(
                  label: 'yes',
                  backgroundcolor: Colors.orange,
                  function: () {
                    //* if user chooses yes, then we set confirm to true
                    confirm = true;
                    Navigator.of(context).pop();
                  }),
              //custom Button 'NO'
              CustomButton(
                  label: 'no',
                  backgroundcolor: Colors.orange,
                  function: () {
                    //* if user chooses no, then we set confirm to false
                    confirm = false;
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
    //return the bool
    return confirm;
  }
}
