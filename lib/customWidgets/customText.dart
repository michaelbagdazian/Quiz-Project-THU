import 'package:flutter/material.dart';

//*this Widet is to print Text on the Page
Widget customText(String text,
    {String fontFam = 'Lobster',
    double fontsize = 50,
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
        fontSize: fontsize,
      ),
    ),
    Text(
      text,
      textAlign: textalign,
      style: TextStyle(
        fontWeight: fontweight,
        fontFamily: fontFam,
        fontSize: fontsize,
        color: backgroundColor,
      ),
    )
  ]);
}
