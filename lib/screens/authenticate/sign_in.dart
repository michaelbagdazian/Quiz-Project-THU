import 'package:crew_brew/services/auth.dart';
import 'package:flutter/material.dart';

// ! This is a sign in screen
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body: Container(
        // ~ Symmetric means left and right have the same padding
        // ~ and bottom and right have the same padding
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
            child: Text('Sign in anon'),
            // ~ It's async, because in her we are going to perform async task to login
            onPressed: () async {
              // ~ Now we want to access signInAnon function in AuthService class in file services/auth.dart
              // ~ if login was succesful, this function will return us the user, or null if it wasn't succesful
              // ~ we define dynamic variable, because we don't know it's type. It could be user, or it could be null
              dynamic result = await _auth.signInAnon();
              if(result == null){
                print("error signing in");
              }else{
                print("signed in");
                print(result.uid);
              }
            }
        ),
      ),
    );
  }
}