// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomText {
//*this Widet is to print Text on the Page
  Widget customText(String text, double welcomeTextSize,
      {String fontFam = 'Lobster',
      Color forgroundColor = Colors.white,
      Color? backgroundColor = Colors.teal,
      FontWeight fontweight = FontWeight.bold,
      TextAlign textalign = TextAlign.center}) {
    return Stack(children: [
      Text(
        text,
        textAlign: textalign,
        style: TextStyle(
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = forgroundColor,
          fontWeight: fontweight,
          fontFamily: fontFam,
          fontSize: welcomeTextSize,
        ),
      ),
      Text(
        text,
        textAlign: textalign,
        style: TextStyle(
          fontWeight: fontweight,
          fontFamily: fontFam,
          fontSize: welcomeTextSize,
          color: backgroundColor,
        ),
      )
    ]);
  }
}
