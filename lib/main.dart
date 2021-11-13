import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:test_pro/pages/WelcomingScreen.dart';
import 'package:test_pro/pages/homePage.dart';
//import 'package:test_pro/pages/homePageMoe.dart';
import 'package:test_pro/pages/login.dart';
import 'package:test_pro/pages/signup.dart';
import 'package:test_pro/pages/user_profile_page.dart';
// import 'package:test_pro/pages/my_quizzes_page.dart';
import 'customWidgets/quiz/quiz.dart';

//!please ignore the following statement for now; it is needed for an unimplemented functionality
Stream<DocumentSnapshot<Map<String, dynamic>>>?
    UserDats; // have to work on this later
//!please ignore the above statement for now; it is needed for an unimplemented functionality

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Quiz(
              questions: ["Monkey", "Penis"],
              answer: "Monkey",
              number: 1,
            ),
        // const WelcominScreen(),
        '/register': (context) => SignUp(),
        '/login': (context) => LogInScreen(),
        '/home': (context) => const home(),
        //'/homeMoe': (context) => homeMoe(),
        '/userProfile': (context) => const userProfile(),
        // '/myQuizes': (context) => myQuizes(),
      },
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'Lobster'),
      //home: WelcominScreen(),
    ),
  );
}
