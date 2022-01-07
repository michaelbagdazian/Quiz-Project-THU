// ignore_for_file: unused_local_variable, file_names, prefer_const_constructors, duplicate_ignore, unnecessary_new

import 'dart:ui';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:crew_brew/shared/customWidgets/customButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customText.dart';
import 'package:crew_brew/shared/customWidgets/customTextField.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crew_brew/shared/colors.dart';

class WelcominScreen extends StatefulWidget {
  WelcominScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcominScreen> createState() => _WelcominScreenState();
}

class _WelcominScreenState extends State<WelcominScreen> {
  //couple of objects
  final CustomText _customText = CustomText();

  //couple of controllers
  final TextEditingController _pinController = TextEditingController();

  final TextEditingController _displayNameController = TextEditingController();

// listen to changes on _displaycontroller
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _displayNameController.addListener(_getDisplayName);
  }

// delete listener when we leave the screen
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _displayNameController.dispose();
    super.dispose();
  }

//get the changes from the _displaycontroller
  Future _getDisplayName() async {
    return _displayNameController.text;
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    /// ~ size of the screen
    Size size = MediaQuery
        .of(context)
        .size;

    /// ~ sizes per widget
    double welcomeTextSize = size.height * (8 / 100);
    double eduLogoHeight = size.height * (13 / 100.0);
    double verticalPadding = size.height * (1 / 100);
    double sizedBoxHeight = size.height * (3 / 100);
    double inputBarWidth = size.width * (60 / 100);
    double buttonWidth = size.width * (8 / 100);

    return Scaffold(
      //see signup.dart
      //resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          //* Background
          image: DecorationImage(
              image: AssetImage('assets/images/bgtop.png'),
              fit: BoxFit.cover),
        ),
        child:
        //*children inside screen
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //*Text
                _customText.customText(
                    "Welcome to\n The Quizzler", welcomeTextSize,
                    backgroundColor: welcomeh),
                //*Logo/pic on welcoming screen
                eduLogo(eduLogoHeight),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                //*create space between the widget and the sides of the screen
                CustomTextField().customTextField(
                  _displayNameController,
                  'Display Name',
                  inputBarWidth,
                  TextInputType.text,
                ),
                SizedBox(height: sizedBoxHeight),
                //* Button
                joinButton(context, buttonWidth),
                SizedBox(height: sizedBoxHeight),
                //*just a widget with the buttons for login or sign up
                //* frontend can improve the quality of this widget by using the custom Widgets; only if they want to
                signInOrUp(context, buttonWidth, sizedBoxHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget joinButton(BuildContext context, double width) {
    return FloatingActionButton.extended(
      heroTag: "joinButton",
      extendedPadding: EdgeInsets.all(width * 0.95),
      extendedIconLabelSpacing: 10,
      onPressed: () async {
        //get the entered display name
        String _username = await _getDisplayName();
        // ~ Signin anonymously
        dynamic result = await _auth.signInAnon(() async {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return customAlertBox("An Error Has Happened !!!", "");
              });
        }, displayName: _username);
        // ~ If login is not succesful, we provide an error message
        if (result == null) {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return customAlertBox(
                    "An Error Has Happened !!!", "Couldn't log in anonymously");
              });
        }
      },
      label: const Text(
        'Join',
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Lobster',
        ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_right_rounded,
        size: 36.0,
      ),
      backgroundColor: buttons,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }

//? The following widget is a column with two buttons and a text between them (login button ---Or--- Register)
  Widget signInOrUp(BuildContext cntxt, double width, double sizedBoxHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText().customText('--- or ---', 30),
        SizedBox(
          height: sizedBoxHeight,
        ),
        CustomButton(
          label: "Sign in",
          backgroundcolor: buttons,
          function: () {
            Navigator.pushNamed(cntxt, '/signin');
          },
          padding: width,
        ),
        SizedBox(
          height: 10,
        ),
        CustomButton(
          label: "Sign up",
          backgroundcolor: buttons,
          function: () {
            Navigator.pushNamed(cntxt, '/register');
          },
          padding: width,
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
              text: 'Check our ',
              style: TextStyle(color: texts, fontFamily: 'Satisfy'),
              children: [
                TextSpan(
                    text: 'Website',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchURLApp();
                      },
                    style: TextStyle(color: links))
              ]),
        ),
      ],
    );
  }

//small little log at the top of the wecloming page, use whatever pic you want or even comment it out if you want to
  Widget eduLogo(double height) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: height,
      height: height,
      child: Image.asset(
        'assets/images/eddu.png',
        fit: BoxFit.cover,
      ),
    );
  }

  //?these are to redirect user to a link
  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url, forceSafariVC: true, forceWebView: true)) {} else {
      throw 'Could not launch $url';
    }
  }
}
