// ignore_for_file: unused_local_variable, file_names, prefer_const_constructors, duplicate_ignore, unnecessary_new

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/customWidgets/customText.dart';
import 'package:test_pro/customWidgets/customTextField.dart';
import 'package:url_launcher/url_launcher.dart';
import 'signup.dart';
import 'login.dart';

class WelcominScreen extends StatelessWidget {
  const WelcominScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //couple of objects
    final CustomTextField _customTextField = new CustomTextField();
    final CustomText _customText = CustomText();
    //couple of controllers
    final TextEditingController _pinController = TextEditingController();
    final TextEditingController _displayNameController =
        TextEditingController();
    //size of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //see signup.dart
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        //*background pic
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/images/bgtop.png',
            fit: BoxFit.cover,
          ),
        ),
        //*children inside screen
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*Text
            _customText.customText("Welcoem to\n The Quizzler !!!",
                backgroundColor: Colors.teal[400]),
            //*Logo/pic on welcoming screen
            eduLogo(),
            SizedBox(
              height: size.height * 0.01,
            ),
            //*create space between the widget and the sides of the screen
            Container(
                padding: EdgeInsets.only(
                  left: (0.2 * size.width),
                  right: (0.2 * size.width),
                ),
                //*text field to add type in the display name; you can probably use the custom ones, but i will leave that to the frontend team
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.yellow)),
                    contentPadding: EdgeInsets.all(15),
                    labelText: 'Display Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Lobster',
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                )),
            SizedBox(height: size.height * 0.01),
            Container(
              padding: EdgeInsets.only(
                left: (0.2 * size.width),
                right: (0.2 * size.width),
              ),
              //*text field to add type in the pin of the live quizz; you can probably use the custom ones, but i will leave that to the frontend team
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _pinController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.yellow)),
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Pin',
                  labelStyle: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            //* Button
            joinButton(),
            SizedBox(height: size.height * 0.05),
            //*just a widget with the buttons for login or sign up
            //* frontend can improve the quality of this widget by using the custom Widgets; only if they want to
            signInOrUp(context),
          ],
        ),
      ]),
    );
  }

  Widget joinButton() {
    return FloatingActionButton.extended(
      heroTag: "joinButton",
      extendedPadding: EdgeInsets.fromLTRB(15, 40, 40, 40),
      extendedIconLabelSpacing: 20,
      onPressed: () {
        //TODO
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
      backgroundColor: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }

  Widget signInOrUp(BuildContext cntxt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(children: [
          Text(
            '--- or ---',
            textAlign: TextAlign.center,
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lobster',
              fontSize: 30,
            ),
          ),
          Text(
            '--- or ---',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lobster',
              fontSize: 30,
              color: Colors.teal,
            ),
          )
        ]),
        SizedBox(
          height: 15,
        ),
        FloatingActionButton.extended(
          extendedPadding: EdgeInsets.all(50),
          heroTag: "LoginButtonOnHomeScreen",
          onPressed: () {
            Navigator.push(
              cntxt,
              MaterialPageRoute(builder: (cntxt) => LogInScreen()),
            );
          },
          label: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lobster',
            ),
          ),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          heroTag: "RegButtonOnHomeScreen",
          extendedPadding: EdgeInsets.all(40),
          onPressed: () {
            Navigator.push(
              cntxt,
              MaterialPageRoute(builder: (cntxt) => SignUp()),
            );
          },
          label: const Text(
            'Register',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lobster',
            ),
          ),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
              text: 'Check our ',
              style: TextStyle(color: Colors.white, fontFamily: 'Satisfy'),
              children: [
                TextSpan(
                    text: 'Website',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchURLApp();
                      },
                    style: TextStyle(color: Colors.blue[900]))
              ]),
        ),
      ],
    );
  }

//small little log at the top of the wecloming page, use whatever pic you want or even comment it out if you want to
  Widget eduLogo() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 100,
      height: 100,
      child: Image.asset(
        'assets/images/eddu.png',
        fit: BoxFit.cover,
      ),
    );
  }

  //?these are to redirect user to a link
  _launchURLBrowser() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url)) {
    } else {
      throw 'Could not launch $url';
    }
  }

  //?these are to redirect user to a link
  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url, forceSafariVC: true, forceWebView: true)) {
    } else {
      throw 'Could not launch $url';
    }
  }
}
