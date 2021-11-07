import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

// ! Authenticate is the wrapper for register and sign_in screens
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  // ~ Toggles the screens
  // ~ This function will be used in register and sign_in when we click on the top right
  // ~ on " register " or "login"
  // ~ we need to pass this function as the parameter to 2 screens
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // ~ Here we pass function toggleView defined a few lines upper to switch between screens
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
