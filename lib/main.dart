import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/pages/WelcomingScreen.dart';
import 'package:test_pro/pages/homePage.dart';
import 'package:test_pro/pages/login.dart';
import 'package:test_pro/pages/signup.dart';
import 'package:test_pro/pages/userProfilePage.dart';
import 'package:test_pro/pages/myQuizesPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcominScreen(),
        '/register': (context) => SignUp(),
        '/login': (context) => LogInScreen(),
        '/home': (context) => home(),
        '/userProfile': (context) => userProfile(),
        '/myQuizes': (context) => myQuizes(),
      },
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'Lobster'),
      //home: WelcominScreen(),
    ),
  );
}
