import 'package:crew_brew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  // ~ text field states
  String email ='';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
      ),
      body: Container(
        // ~ Symmetric means left and right have the same padding
        // ~ and bottom and right have the same padding
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        // ~ Form widget allows us to do form validation later on
        child: Form(
          child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                // ~ TextFormField for the e-mail
                TextFormField(
                    onChanged: (val){
                      // ~ We take email state and set it equal to value which is in e-mail textField
                      setState(() => email = val);
                    }
                ),
                SizedBox(height: 20.0),
                // ~ TextForField the the password
                TextFormField(
                  // ~ This hides the password when entering it
                    obscureText: true,
                    onChanged: (val){
                      // ~ We take password state and set it equal to value which is in password textField
                      setState(() => password = val);
                    }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    // ~ onPressed is async, because we interract with Firebase and it takes some time
                    onPressed: () async{
                      print(email);
                      print(password);
                    }
                )
              ]
          ),
        ),
      ),
    );
  }
}
