import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/shared/constants.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class is the screen for login
// ! Use of the class:
// ~ This class extracts the information from the user necessary for login

// ! TODOS:
// TODO Integrate the pretty design of login page

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  // final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // ! AuthService instance:
  // ~ We need this instance to have access to the method defined in services/auth.dart called signInWithEmailAndPassword()
  final AuthService _auth = AuthService();

  // ! formKey:
  // ~ This key we are going to use to identify our form and we are
  // ~ going to associate our forms with this global FormState key
  // ~ when we want to validate our form, then we do it via this formKey
  final _formKey = GlobalKey<FormState>();

  // ! Loading state:
  // ~ when loading is true, then instead of Scaffold we will be showing Loading widget
  // ~ it is set to true befure we provide data to the DB, waiting for it to respond
  bool loading = false;

  // ! Text field states:
  // ~ This are the states which are used to request the data from the user for registration
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // ! popScreen():
    // ~ Since we want to allow our user to go back to welcome screen ( perhaps he figures out that he is already registered ), we keep register screen on stack
    // ~ After the login was successful, we remove the screen from the stack before moving to Home screen, so that we do not allow user to get back to registration
    // ~ If he has just already registered
    void popScreen() {
      Navigator.pop(context);
    }

    // ! If true, we return loading widget, otherwise Scaffold
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Quiz App'),
            ),
            body: Container(
              // ~ Symmetric means left and right have the same padding
              // ~ and bottom and right have the same padding
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // ! Form widget allows us to do form validation using property "validator". This allows us to put some contains on the provided information
              child: Form(
                // ~ Here we are associating our global FormKey with our form
                // ~ this will basically keep track of our form and the state of our form
                // ~ when we want to validate our form, then we do it via this formKey
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  // * Start of TextFormField for the e-mail
                  TextFormField(
                      // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      // ! validator property:
                      // ~ we return null value if this formField is VALID or a string it's NOT VALID
                      // ~ validator will be used in RaisedButton when calling _formKey.currentState!.validate()
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      // ! onChanged property:
                      // ~ When information is entered into the TextForField, this property is triggered
                      onChanged: (val) {
                        // ~ We take email state and set it equal to value which is in e-mail textField
                        // ~ We also make use of trim() function to remove any spaces
                        setState(() => email = val.trim());
                      }),
                  // * End of TextFormField for the e-mail
                  SizedBox(height: 20.0),
                  // * Start of TextForField for the password
                  TextFormField(
                      // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      // ~ This hides the password when entering it
                      obscureText: true,
                      // ! validator property:
                      // ~ we return null value if this formField is VALID or a string it's NOT VALID
                      // ~ validator will be used in RaisedButton when calling _formKey.currentState!.validate()
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      // ! onChanged property:
                      // ~ When information is entered into the TextForField, this property is triggered
                      onChanged: (val) {
                        // ~ We take password state and set it equal to value which is in password textField
                        // ~ We also make use of trim() function to remove any spaces
                        setState(() => password = val);
                      }),
                  // * End of TextForField for the password
                  SizedBox(height: 20.0),
                  // * Start of Signin button
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      // ! onPressed():
                      // ~ onPressed is async, because we interract with Firebase and it takes some time
                      onPressed: () async {
                        // ~ Here we check if our form is valid
                        // ~ currentState tells us what values are inside the form fields
                        // ~ validate() method uses validator properties in the TextFormFields
                        if (_formKey.currentState!.validate()) {
                          // * Here we decide to show the loading screen
                          setState(() => loading = true);
                          // ~ We will get null or AppUser, so we don't know the type of return. Therefore we use dynamic
                          // ~ We await for the result from the Firebase
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          // ~ If login is not succesful, we provide an error message
                          if (result == null) {
                            setState(() {
                              error =
                                  'could not sign in with those credentials';
                              // * Here we decide to remove the loading screen
                              loading = false;
                            });
                            // ! If login is successful:
                            // ~ pop current screen from the stack then it's automatically redirected to Home page
                          } else {
                            popScreen();
                          }
                        }
                      }),
                  // * End of Signin button
                  SizedBox(height: 20.0),
                  // * Start of Signin anonymously button
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in anonymously',
                        style: TextStyle(color: Colors.white),
                      ),
                      // ! onPressed():
                      // ~ onPressed is async, because we interract with Firebase and it takes some time
                      onPressed: () async {
                          // * Here we decide to show the loading screen
                          setState(() => loading = true);
                          // ~ Signin anonymously
                          dynamic result = await _auth.signInAnon();
                          // ~ If login is not succesful, we provide an error message
                          if (result == null) {
                            setState(() {
                              error = 'could not sign in with those credentials';
                              // * Here we decide to remove the loading screen
                              loading = false;
                            });
                            // ! If login is successful:
                            // ~ pop current screen from the stack then it's automatically redirected to Home page
                          } else {
                            popScreen();
                          }
                        }
                      ),
                  // * End of Signin anonymously button
                  SizedBox(height: 12.0),
                  // ! Text widget for error message:
                  // ~ This widget is empty in the beginning, and is updated if there is an error.
                  Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0)),
                ]),
              ),
            ),
          );
  }
}
