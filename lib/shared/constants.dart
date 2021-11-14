import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class contains all constant widgets
// ! Use of the class:
// ~ This class just makes constant widgets reusable. For extensability copyWith method can be used ( see example in register page TextFormField for the username -> decoration )

// ! TODOs
// TODO Move another custom widgets here

const textInputDecoration = InputDecoration(
  // ~ This makes the textField white background
  fillColor: Colors.white,
  filled: true,
  // ~ When FormField is not selected, then it has these properties
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  // ~ When FormField is selected, then it has these properties
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);