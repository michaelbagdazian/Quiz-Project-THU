import 'package:crew_brew/screens/authenticate/authenticate.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

// ! Welcome acts as wrapper for login and register. Replacement for authenticate.dart
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
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                // ~ onPressed is async, because we interract with Firebase and it takes some time
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                }),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                // ~ onPressed is async, because we interract with Firebase and it takes some time
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                }),
          ]),
        ),
      );
  }
}
