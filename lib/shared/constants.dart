import 'package:flutter/material.dart';

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
