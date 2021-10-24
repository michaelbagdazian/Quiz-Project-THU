import 'package:flutter/material.dart';
import 'login_interface.dart';
import 'Background.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lobster'),
      home: const login_interface(),
    ),
  );
}
