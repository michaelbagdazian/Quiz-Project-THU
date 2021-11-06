import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/shared/constants.dart';
import 'package:flutter/material.dart';

// ! This is a sign-in screen
class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  // ~ This key we are going to use to identify our form and we are
  // ~ going to assosiate our form with this global FormState key
  final _formKey = GlobalKey<FormState>();

  // ~ text field states
  String email ='';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed:(){
              // ~ This calls toggleView function from authenticate.dart
              widget.toggleView();
            }
          ),
        ],
      ),
      body: Container(
        // ~ Symmetric means left and right have the same padding
        // ~ and bottom and right have the same padding
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        // ~ Form widget allows us to do form validation later on
        child: Form(
          // ~ Here we are associating our global FormKey with our form
          // ~ this will basically keep track of our form and the state of our form
          // ~ in the future we want to validate our form, then we do it via this formKey
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              // ~ TextFormField for the e-mail
              TextFormField(
                // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                // ~ we return null value is this formField is valid or a string
                // ~ if it's not valid
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  // ~ We take email state and set it equal to value which is in e-mail textField
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              // ~ TextForField the the password
              TextFormField(
                // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                // ~ This hides the password when entering it
                obscureText: true,
                // ~ we return null value is this formField is valid or a string
                // ~ if it's not valid
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val){
                  // ~ We take password state and set it equal to value which is in password textField
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                // ~ onPressed is async, because we interract with Firebase and it takes some time
                onPressed: () async {
                  // ~ Here we check if our form is valid
                  // ~ currentState tells us what values are inside the form fields
                  // ~ validate method uses validator properties in the TextFormFields
                  if (_formKey.currentState!.validate()) {
                    // ~ We will get null or AppUser, so we don't know the type of return. Therefore we use dynamic
                    // ~ We await for the result
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    // ~ If login is not succesful, we provide an error message
                    if (result == null) {
                      setState(() => error = 'could not sign in with those credentials');
                    }
                    // ~ If login was succesful, we have a stream setup in our root widget which
                    // ~ listens to all changes and when a user succesfuly logins we get that
                    // ~ user back and that user comes back to the stream
                    // ~ so home page will be shown automatically
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                // ~ Here we print the error
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
                ),
            ]
          ),
        ),
      ),
    );
  }
}