import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'WelcomingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'Lobster'),
      home: const WelcominScreen(),
    ),
  );
}
