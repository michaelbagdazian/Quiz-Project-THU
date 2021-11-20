import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/shared/constants.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customText.dart';

// ! Information about the class:
// ~ This class is the screen for login
// ! Use of the class:
// ~ This class extracts the information from the user necessary for login

// ! TODOS:
// TODO Integrate the pretty design of login page

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  // final Function toggleView;

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // ! AuthService instance:
  // ~ We need this instance to have access to the method defined in services/auth.dart called signInWithEmailAndPassword()
  final AuthService _auth = AuthService();
  final _customText = CustomText();

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
    Size size = MediaQuery.of(context).size;
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Sign In',
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 30,
                ),
              ),
              backgroundColor: Colors.teal,
            ),
            body:Container(
              child: Form(
                key:_formKey,
                child: Stack(fit: StackFit.expand, children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/bgtop.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        //*Add the welcoming text first
                        _customText.customText('Log In to Your\n Account'),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        TextFormField(
                          //!! Merging
                            keyboardType: TextInputType.emailAddress,

                            // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.yellow)),
                              contentPadding: const EdgeInsets.all(15),
                              labelText: "E-mail",
                              labelStyle: const TextStyle(
                                fontFamily: 'Lobster',
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          //!! Merging
                            keyboardType: TextInputType.visiblePassword,

                            // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.yellow)),
                              contentPadding: const EdgeInsets.all(15),
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                fontFamily: 'Lobster',
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            // ! TextInputDecoration is defined in shared/constants.dart. We extend the predefined widget with method 'copyWith'
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        FloatingActionButton.extended(
                          // ! onPressed():
                          // ~ onPressed is async, because we interract with Firebase and it takes some time
                          onPressed: () async {
                            print("I AM HEEERE1");
                            // ~ Here we check if our form is valid
                            // ~ currentState tells us what values are inside the form fields
                            // ~ validate() method uses validator properties in the TextFormFields
                            if (_formKey.currentState!.validate()) {
                              print("I AM HEEERE2");
                              // * Here we decide to show the loading screen
                              setState(() => loading = true);
                              // ~ We will get null or AppUser, so we don't know the type of return. Therefore we use dynamic
                              // ~ We await for the result from the Firebase
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              // ~ If login is not succesful, we provide an error message
                              if (result == null) {
                                print("I AM HEEER3");
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
                                print("I AM HEEERE4");
                              }
                            }
                          },
                          label: Text(
                            "Log in",
                            style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'Lobster',
                            ),
                          ),
                          backgroundColor: Colors.orange,
                          extendedPadding: const EdgeInsets.all(40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        FloatingActionButton.extended(
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
                              print("POPING SCREEN");
                              popScreen();
                            }
                          },
                          label: Text(
                            "Log in anonymously",
                            style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'Lobster',
                            ),
                          ),
                          backgroundColor: Colors.orange,
                          extendedPadding: const EdgeInsets.all(40),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0)),
                      ]),
                ]),
              ),
            )

          );
  }
}
