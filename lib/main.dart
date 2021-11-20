import 'dart:js';

import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/authenticate/sign_in.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/quizes/myQuizes.dart';
import 'package:crew_brew/screens/quizes/sharedQuizes.dart';
import 'package:crew_brew/screens/userProfile/userProfile.dart';
import 'package:crew_brew/screens/authenticate/welcome.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/screens/authenticate/merging/register.dart';
import 'package:crew_brew/screens/authenticate/merging/sign_in.dart';
import 'package:crew_brew/screens/authenticate/merging/WelcomingScreen.dart';

// ! Information about the class:
// ~ Main class
// ! Use of the class:
// ~ Root of our app

// ! TODOs
// all done

void main() async {
  // ~ Initialize fireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ! StreamProvider<AppUser?>
    // ~ Here we create StreamProvider, which is defined in services/auth.dart and provide the information
    // ~ about user authentication among all the classes of our app, since this Stream is defined at the root
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        // ! routes
        // ~ Here we define all routes of our apps. They are mainly used in navigationBar/navBar.dart -> selectedItem()
        routes: {
          '/home': (context) => Home(),
          '/userProfile': (context) => userProfile(),
          '/sharedQuizes': (context) => SharedQuizes(),
          '/myQuizes': (context) => MyQuizes(),
          //!merging
          '/welcome': (context) => WelcominScreen(),
          '/register': (context) => SignUp(),
          '/signin': (context) => LogIn(),
          //!original
          // '/welcome': (context) => Welcome(),
          // '/register': (context) => Register(),
          // '/signin': (context) => SignIn(),
        },
      ),
    );
  }
}
