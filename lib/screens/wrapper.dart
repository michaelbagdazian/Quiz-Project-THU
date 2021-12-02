import 'package:crew_brew/screens/authenticate/merging/WelcomingScreen.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/authenticate/welcome.dart';
import 'package:crew_brew/screens/quizes/addQuestionsUI.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

// ! Information about the class:
// ~ This class acts as wrapper for Welcome() and Home()
// ! Use of the class:
// ~ It decides whever to output Home or Welcome screen
// ~ So if you close the app without logging out ( remove the app from the RAM ), next time you will still be logged in

// ! TODOS:
// all done

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    // ! If user is not logged in, return Welcome() screen. Otherwise Home() screen
    if (user == null) {
      return AddQuestionsUI();
    } else {
      return Home();
    }
  }
}
