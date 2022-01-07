// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

/*
this is a custom button
it takes a label, a color and a funciton that is void incase you don't want your button to do anything
 */
class CustomButton extends StatelessWidget {
  String label;
  Color backgroundcolor;
  VoidCallback? function;
  double? padding;

  CustomButton({
    Key? key,
    required this.label,
    required this.backgroundcolor,
    required this.function,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //check if padding is passed, if not we pass 40 as the edgeinsets
    padding = padding ?? 40;
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: () {
        function!();
      },
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 25,
          fontFamily: 'Lobster',
        ),
      ),
      backgroundColor: backgroundcolor,
      extendedPadding: EdgeInsets.all(padding!),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
