import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class is what our new user sees when he opens the app
// ! Use of the class:
// ~ This class acts as wrapper for register and login

// ! TODOS:
// TODO Integrate the pretty design of welcome page

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Welcome to Quiz App'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          // * Start of Register button
          RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              // ! onPressed():
              // ~ When registration button is pressed, register screen is pushed on stack
              onPressed: () {
                // ! pushNamed():
                // ~ Push means that we push the screen on top of the current screen
                // ~ Named means that we are using routing defined in main.dart
                Navigator.pushNamed(context, '/register');
              }),
          // * End of Register button
          RaisedButton(
              // * Start of Login button
              color: Colors.pink[400],
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              // ! onPressed():
              // ~ When registration button is pressed, register screen is pushed on stack
              onPressed: () {
                // ! pushNamed():
                // ~ Push means that we push the screen on top of the current screen
                // ~ Named means that we are using routing defined in main.dart
                Navigator.pushNamed(context, '/signin');
              }),
          // * End of Login button
        ]),
      ),
    );
  }
}
