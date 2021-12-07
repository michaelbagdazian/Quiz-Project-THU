// ignore_for_file: file_names

import 'package:flutter/material.dart';

/*
this is a custom button
it takes a label, a color and a funciton that is void incase you don't want your button to do anything
 */
class CustomButton extends StatelessWidget {
  String label;
  Color backgroundcolor;
  VoidCallback? function;

  CustomButton({
    Key? key,
    required this.label,
    required this.backgroundcolor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: () {
        function!();
      },
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 30,
          fontFamily: 'Lobster',
        ),
      ),
      backgroundColor: backgroundcolor,
      extendedPadding: const EdgeInsets.all(40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
