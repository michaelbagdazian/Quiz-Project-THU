// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomButton {
//*this is A button with the label 'register on it'
  Widget customButton(String _label, Color _backgroundcolor, void _function) {
    return FloatingActionButton.extended(
      onPressed: () {
        _function;
      },
      label: Text(
        _label,
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'Lobster',
        ),
      ),
      backgroundColor: _backgroundcolor,
      extendedPadding: const EdgeInsets.all(40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
