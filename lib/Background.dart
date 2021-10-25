// ignore_for_file: unused_local_variable, file_names, prefer_const_constructors, duplicate_ignore

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/login_interface.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_signup.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinController = TextEditingController();
    final TextEditingController _displayNameController =
        TextEditingController();
    // ignore: todo
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            'assets/images/bgtop.png',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            helloMessage(),
            eduLogo(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: (0.2 * size.width),
                  right: (0.2 * size.width),
                ),
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
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            joinButton(context),
            SizedBox(height: size.height * 0.05),
            signInOrUp(),
          ],
        ),
      ]),
    );
  }

  Widget helloMessage() {
    // ignore: prefer_const_literals_to_create_immutables
    return Stack(children: [
      Text(
        'The Quizzler Welcomes You !!!',
        textAlign: TextAlign.center,
        style: TextStyle(
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lobster',
          fontSize: 50,
        ),
      ),
      Text(
        'The Quizzler Welcomes You !!!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Lobster',
          fontSize: 50,
          color: Colors.teal[400],
        ),
      )
    ]);
  }

  Widget joinButton(BuildContext cntxt) {
    return FloatingActionButton.extended(
      extendedPadding: EdgeInsets.fromLTRB(15, 40, 40, 40),
      extendedIconLabelSpacing: 20,
      onPressed: () {
        //TODO
        Navigator.push(
          cntxt,
          new MaterialPageRoute(builder: (cntxt) => new RegisterScreen()),
        );
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
      backgroundColor: Colors.teal[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }

  Widget signInOrUp() {
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
          onPressed: () {
            //TODO
          },
          label: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lobster',
            ),
          ),
          backgroundColor: Colors.teal[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          extendedPadding: EdgeInsets.all(40),
          onPressed: () {
            //TODO
          },
          label: const Text(
            'Register',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Lobster',
            ),
          ),
          backgroundColor: Colors.teal[400],
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

  _launchURLBrowser() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url)) {
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await launch(url, forceSafariVC: true, forceWebView: true)) {
    } else {
      throw 'Could not launch $url';
    }
  }
}
/* decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/bgtop.png'),
          fit: BoxFit.cover,
        ),
      )*/